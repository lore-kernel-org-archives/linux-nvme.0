From: minwoo.im.dev@gmail.com (Minwoo Im)
Date: Wed, 10 Apr 2019 23:11:34 +0900
Subject: Potential bug in queue_count_set
In-Reply-To: <b62dde65-1abf-1391-9de6-9bcdf6a7fa07@gmail.com>
References: <b62dde65-1abf-1391-9de6-9bcdf6a7fa07@gmail.com>
Message-ID: <d945096a-14d8-6d9f-187f-39501dfdb600@gmail.com>

On 4/10/19 10:33 PM, Maximilian Luz wrote:
> Hi all,
> 
> I just stumbled (more or less randomly) over this piece of code
> (/drivers/nvme/host/pci.c, v5.1-rc4):
> 
> 147: static int queue_count_set(const char *val, const struct 
> kernel_param *kp)
> 148: {
> 149:???? int n = 0, ret;
> 150:
> 151:???? ret = kstrtoint(val, 10, &n);
> 152:???? if (ret)
> 153:???????? return ret;
> 154:???? if (n > num_possible_cpus())
> 155:???????? n = num_possible_cpus();
> 156:
> 157:???? return param_set_int(val, kp);
> 158: }
> 
> Link with context: 
> https://github.com/torvalds/linux/blob/v5.1-rc4/drivers/nvme/host/pci.c#L154-L155 
> 
> 
> It looks like lines 154, 155 don't achieve anything as `n` is not being
> used afterwards. Sorry if this is already known or a non-issue, just
> wanted to let you guys know.
> 

It looks like module parameter "write_queues" is set to the actual given
value (val) without considering reduced number of queues in case given
value is greater than nr_cpus.

I think that might need sprintf() or something like this to make the
actual value reduced in that case.

> Maximilian
> 
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme
