/* Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 * 
 *      http://www.apache.org/licenses/LICENSE-2.0
 * 
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package org.flowable.cmmn.engine.impl.cmd;

import java.util.Map;

import org.flowable.cmmn.engine.CmmnEngineConfiguration;
import org.flowable.cmmn.engine.impl.persistence.entity.PlanItemInstanceEntity;
import org.flowable.cmmn.engine.impl.util.CommandContextUtil;
import org.flowable.common.engine.api.FlowableIllegalArgumentException;
import org.flowable.common.engine.api.FlowableObjectNotFoundException;
import org.flowable.common.engine.impl.interceptor.Command;
import org.flowable.common.engine.impl.interceptor.CommandContext;

public class SetLocalVariablesAsyncCmd extends AbstractSetVariableAsyncCmd implements Command<Void> {
    
    protected String planItemInstanceId;
    protected Map<String, Object> variables;
    
    public SetLocalVariablesAsyncCmd(String planItemInstanceId, Map<String, Object> variables) {
        this.planItemInstanceId = planItemInstanceId;
        this.variables = variables;
    }
    
    @Override
    public Void execute(CommandContext commandContext) {
        if (planItemInstanceId == null) {
            throw new FlowableIllegalArgumentException("planItemInstanceId is null");
        }
        if (variables == null) {
            throw new FlowableIllegalArgumentException("variables is null");
        }
        if (variables.isEmpty()) {
            throw new FlowableIllegalArgumentException("variables is empty");
        }
     
        CmmnEngineConfiguration cmmnEngineConfiguration = CommandContextUtil.getCmmnEngineConfiguration(commandContext);
        PlanItemInstanceEntity planItemInstanceEntity = cmmnEngineConfiguration.getPlanItemInstanceEntityManager().findById(planItemInstanceId);
        if (planItemInstanceEntity == null) {
            throw new FlowableObjectNotFoundException("No plan item instance found for id " + planItemInstanceId, PlanItemInstanceEntity.class);
        }
        
        for (String variableName : variables.keySet()) {
            addVariable(true, planItemInstanceEntity.getCaseInstanceId(), planItemInstanceEntity.getId(), variableName, variables.get(variableName), 
                    planItemInstanceEntity.getTenantId(), cmmnEngineConfiguration.getVariableServiceConfiguration().getVariableService());
        }
        
        createSetAsyncVariablesJob(planItemInstanceEntity, cmmnEngineConfiguration);
        
        return null;
    }

}
