package com.materialize.jee.platform.batch.domain;

import java.io.Serializable;

public class MapreduceBatchJobStepInstance implements Serializable {
	private static final long serialVersionUID = 1L;
	
	/**
	 * 主键
	 */
	private java.lang.Long id;
	
	/**
	 * jobid
	 */
	private java.lang.Long jobId;
	
	/**
	 * stepid
	 */
	private java.lang.Long stepId;
	
	/**
	 * hadoop集群中任务ID
	 */
	private java.lang.Long hadoopJobId;
	
	/**
	 * 运行参数，多个用逗号隔开
	 */
	private java.lang.String jobParams;
	
	/**
	 * 开始运行时间
	 */
	private java.util.Date startTime;
	
	/**
	 * 运行结束时间
	 */
	private java.util.Date endTime;
	
	/**
	 * 步骤状态 0-创建 1-运行中 2-结束
	 */
	private java.lang.Integer stepState;
	
	/**
	 * 结果编码
	 */
	private java.lang.String resultCode;
	
	/**
	 * 结果描述
	 */
	private java.lang.String resultDesc;
	
	/**
	 * 创建者
	 */
	private java.lang.Long createId;
	
	public java.lang.Long getId() {
        return id;
    }
    
    public void setId(java.lang.Long id) {
        this.id = id;
    }
    
	public java.lang.Long getJobId() {
        return jobId;
    }
    
    public void setJobId(java.lang.Long jobId) {
        this.jobId = jobId;
    }
    
	public java.lang.Long getStepId() {
        return stepId;
    }
    
    public void setStepId(java.lang.Long stepId) {
        this.stepId = stepId;
    }
    
	public java.lang.Long getHadoopJobId() {
        return hadoopJobId;
    }
    
    public void setHadoopJobId(java.lang.Long hadoopJobId) {
        this.hadoopJobId = hadoopJobId;
    }
    
	public java.lang.String getJobParams() {
        return jobParams;
    }
    
    public void setJobParams(java.lang.String jobParams) {
        this.jobParams = jobParams;
    }
    
	public java.util.Date getStartTime() {
        return startTime;
    }
    
    public void setStartTime(java.util.Date startTime) {
        this.startTime = startTime;
    }
    
	public java.util.Date getEndTime() {
        return endTime;
    }
    
    public void setEndTime(java.util.Date endTime) {
        this.endTime = endTime;
    }
    
	public java.lang.Integer getStepState() {
        return stepState;
    }
    
    public void setStepState(java.lang.Integer stepState) {
        this.stepState = stepState;
    }
    
	public java.lang.String getResultCode() {
        return resultCode;
    }
    
    public void setResultCode(java.lang.String resultCode) {
        this.resultCode = resultCode;
    }
    
	public java.lang.String getResultDesc() {
        return resultDesc;
    }
    
    public void setResultDesc(java.lang.String resultDesc) {
        this.resultDesc = resultDesc;
    }
    
	public java.lang.Long getCreateId() {
        return createId;
    }
    
    public void setCreateId(java.lang.Long createId) {
        this.createId = createId;
    }
    
}