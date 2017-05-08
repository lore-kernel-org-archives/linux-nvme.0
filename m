From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Mon, 8 May 2017 11:50:19 +0200
Subject: [PATCH] nvmet_fc: Reduce work_q count
In-Reply-To: <20170425232241.2938-1-jsmart2021@gmail.com>
References: <20170425232241.2938-1-jsmart2021@gmail.com>
Message-ID: <a832b201-6bec-c90f-484a-081524c1f06b@suse.de>

Hi James,

On 04/26/2017 01:22 AM, jsmart2021@gmail.com wrote:
> From: James Smart <jsmart2021 at gmail.com>
> 
> Instead of a work_q per controller queue, make 1 per cpu and have controller
> queues post work elements to the work_q.
> 
> Signed-off-by: James Smart <james.smart at broadcom.com>
> ---

[...]

>  
> +enum nvmet_fc_workcpu_flags {
> +	NVMET_FC_CPU_RUNNING		= (1 << 0),
> +	NVMET_FC_CPU_TERMINATING	= (1 << 1),
> +};
> +
> +struct nvmet_fc_work_by_cpu {
> +	struct workqueue_struct		*work_q;
> +	struct list_head		fod_list;
> +	spinlock_t			clock;
> +	int				cpu;
> +	bool				running;
> +	struct work_struct		cpu_work;
> +};
> +
>  
>  static inline int
>  nvmet_fc_iodnum(struct nvmet_fc_ls_iod *iodptr)
> @@ -213,10 +228,10 @@ static DEFINE_SPINLOCK(nvmet_fc_tgtlock);
>  static LIST_HEAD(nvmet_fc_target_list);
>  static DEFINE_IDA(nvmet_fc_tgtport_cnt);
>  
> +static u32 nvmet_fc_cpu_cnt;
> +static struct nvmet_fc_work_by_cpu nvmet_fc_workcpu[NR_CPUS];

Is there a reason that prevents you from using DEFINE_PER_CPU() here
instead of that array?

[...]

> +static void
> +nvmet_fc_do_work_on_cpu(struct work_struct *work)
> +{
> +	struct nvmet_fc_work_by_cpu *workcpu =
> +		container_of(work, struct nvmet_fc_work_by_cpu, cpu_work);
> +	struct nvmet_fc_fcp_iod *fod;
> +	unsigned long flags;
> +
> +	do {
> +		spin_lock_irqsave(&workcpu->clock, flags);
> +		fod = list_first_entry_or_null(&workcpu->fod_list,
> +					struct nvmet_fc_fcp_iod, work_list);
> +		if (fod)
> +			list_del(&fod->work_list);
> +		else
> +			workcpu->running = false;
> +		spin_unlock_irqrestore(&workcpu->clock, flags);
> +		if (fod) {
> +			if (fod->started)
> +				nvmet_fc_fod_op_done(fod);
> +			else
> +				nvmet_fc_handle_fcp_rqst(fod->tgtport, fod);
> +		}
> +	} while (fod);
> +}

This do {} while(fod) construct looks a bit unusual to me. I do agree
using a 'while (!list_empty(&workcpu->fod_list))' loop requires you two
list_empty() calls (the 2nd would be in list_first_emtpy_or_null()) but
is IMHO a bit more readable. Or am I missing something here?

> +
> +static int
> +nvmet_fc_create_threads(void)

nvmet_fc_create_workqueues()? After all you're creating a workqueue not
a kthread.


-- 
Johannes Thumshirn                                          Storage
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
