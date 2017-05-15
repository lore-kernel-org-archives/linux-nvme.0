From: james.smart@broadcom.com (James Smart)
Date: Mon, 15 May 2017 15:39:13 -0700
Subject: [PATCH 06/10] nvmet_fc: Reduce work_q count
In-Reply-To: <5e0fefab-9a20-a409-8ff2-6eefe3ab1649@suse.de>
References: <20170513190309.25417-1-jsmart2021@gmail.com>
 <20170513190309.25417-7-jsmart2021@gmail.com>
 <5e0fefab-9a20-a409-8ff2-6eefe3ab1649@suse.de>
Message-ID: <5ca80708-59d9-d7d1-6102-67ff2d1c1b8f@broadcom.com>

On 5/14/2017 11:40 PM, Hannes Reinecke wrote:
> On 05/13/2017 09:03 PM, James Smart wrote:
>> +static u32 nvmet_fc_cpu_cnt;
>> +static DEFINE_PER_CPU(struct nvmet_fc_work_by_cpu, nvmet_fc_cpu_workcpu);
>> +#define nvmet_fc_workcpu(cpu)	(&per_cpu(nvmet_fc_cpu_workcpu, cpu))
>>   
>> ...
>> +static void
>> +nvmet_fc_delete_workqueues(void)
>> +{
>> +	struct nvmet_fc_work_by_cpu *workcpu;
>> +	int i;
>> +
>> +	for (i = 0; i < nvmet_fc_cpu_cnt; i++, workcpu++) {
>> +		workcpu = nvmet_fc_workcpu(i);
>> +
>> +		/* sanity check - all work should be removed */
>> +		if (!list_empty(&workcpu->fod_list))
>> +			pr_warn("%s: cpu %d worklist not empty\n", __func__, i);
>> +
>> +		if (workcpu->work_q)
>> +			destroy_workqueue(workcpu->work_q);
>> +	}
>> +}
>> +
>>   ...
>>
> Per-cpu ptr?
> Check drivers/scsi/fcoe/fcoe.c:fcoe_init() for reference.

As you can see above - I'm using per_cpu(), which is actually "#define 
per_cpu(var, cpu)       (*per_cpu_ptr(&(var), cpu))". So I'm already 
using it.

-- james
