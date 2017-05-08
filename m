From: jsmart2021@gmail.com (James Smart)
Date: Mon, 8 May 2017 09:41:14 -0700
Subject: [PATCH] nvmet_fc: Reduce work_q count
In-Reply-To: <a832b201-6bec-c90f-484a-081524c1f06b@suse.de>
References: <20170425232241.2938-1-jsmart2021@gmail.com>
 <a832b201-6bec-c90f-484a-081524c1f06b@suse.de>
Message-ID: <5fcd1a92-0d59-b50a-cede-04242cfd78da@gmail.com>

On 5/8/2017 2:50 AM, Johannes Thumshirn wrote:
> Hi James,
>
> On 04/26/2017 01:22 AM, jsmart2021@gmail.com wrote:
>>
>> +static u32 nvmet_fc_cpu_cnt;
>> +static struct nvmet_fc_work_by_cpu nvmet_fc_workcpu[NR_CPUS];
>
> Is there a reason that prevents you from using DEFINE_PER_CPU() here
> instead of that array?

Nope. I'll repost with the change.


>
> This do {} while(fod) construct looks a bit unusual to me. I do agree
> using a 'while (!list_empty(&workcpu->fod_list))' loop requires you two
> list_empty() calls (the 2nd would be in list_first_emtpy_or_null()) but
> is IMHO a bit more readable. Or am I missing something here?

Nope. It's not a big deal so I'll include this as well.

>
>> +
>> +static int
>> +nvmet_fc_create_threads(void)
>
> nvmet_fc_create_workqueues()? After all you're creating a workqueue not
> a kthread.

:)  sure.

-- james
