From: mlin@kernel.org (Ming Lin)
Date: Fri, 20 May 2016 10:57:13 -0700
Subject: [PATCH v2 1/2] nvme: switch to RCU freeing the namespace
In-Reply-To: <20160520141649.GC28795@localhost.localdomain>
References: <CAF1ivSaOMqLP=a9KgNy0Gbn9w_KkCzwbuY80e=sCJR+4Vg2kNw@mail.gmail.com>
 <20160517150511.GB14260@localhost.localdomain>
 <20160517152359.GC14260@localhost.localdomain>
 <20160517153003.GA18529@localhost.localdomain>
 <CAF1ivSaEg2wiH3hwpRmeK7ua69ERT5MP8MqZyuc6Dtb2fes6gg@mail.gmail.com>
 <20160517210706.GB19325@localhost.localdomain>
 <CAF1ivSbi8rXgsM885w0EMyzMnDuiGOUUfu3o+RKbz1KG2jJW6Q@mail.gmail.com>
 <20160517212542.GC19325@localhost.localdomain>
 <1463637146.8610.4.camel@kernel.org>
 <20160519204829.GB28795@localhost.localdomain>
 <20160520141649.GC28795@localhost.localdomain>
Message-ID: <CAF1ivSZESXwxaXsrqHXC2Hpgadk7iphW41w56EFym-015Ed6Cg@mail.gmail.com>

On Fri, May 20, 2016@7:16 AM, Keith Busch <keith.busch@intel.com> wrote:
> On Thu, May 19, 2016@04:48:29PM -0400, Keith Busch wrote:
>> On Wed, May 18, 2016@10:52:26PM -0700, Ming Lin wrote:
>> > I have not found the root cause yet.
>> > Below patch makes reset not occur during active scan work.
>> > And I didn't see the crash any more with this patch.
>> >
>> > So it seems there is a race somewhere between reset work and scan work.
>
> I haven't been able to reproduce the same failure you're getting. What I
> see is namespaces being validated fail because the user interrupted the
> process by disabling the controller in the middle of discovery. That's
> not good either.

Sorry I should mention that I was testing nvme-over-fabric tree.
I can't reproduce it either with Linus tree.

>
> We can't just fence off resets during discovery since we need to let
> recovery occur if a controller fails.
>
> There's no good reason to let a user interrupt the process, though.
>
> How about for user initiated resets, we synchronize with the scan
> work and set a controller state that allows resets but not scan:

I didn't see the crash any more with below patch applied to
nvme-over-fabric tree.
I'll still try to find out what the root cause is.

Thanks.

>
> ---
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 1a51584..f7e15df 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -1209,6 +1209,13 @@ out_unlock:
>         return ret;
>  }
>
> +static int nvme_reset_ctrl(struct nvme_ctrl *ctrl)
> +{
> +       ctrl->state = NVME_CTRL_NEW;
> +       flush_work(&ctrl->scan_work);
> +       return ctrl->ops->reset_ctrl(ctrl);
> +}
> +
>  static long nvme_dev_ioctl(struct file *file, unsigned int cmd,
>                 unsigned long arg)
>  {
> @@ -1222,7 +1229,7 @@ static long nvme_dev_ioctl(struct file *file, unsigned int cmd,
>                 return nvme_dev_user_cmd(ctrl, argp);
>         case NVME_IOCTL_RESET:
>                 dev_warn(ctrl->device, "resetting controller\n");
> -               return ctrl->ops->reset_ctrl(ctrl);
> +               return nvme_reset_ctrl(ctrl);
>         case NVME_IOCTL_SUBSYS_RESET:
>                 return nvme_reset_subsystem(ctrl);
>         case NVME_IOCTL_RESCAN:
> @@ -1248,7 +1255,7 @@ static ssize_t nvme_sysfs_reset(struct device *dev,
>         struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
>         int ret;
>
> -       ret = ctrl->ops->reset_ctrl(ctrl);
> +       ret = nvme_reset_ctrl(ctrl);
>         if (ret < 0)
>                 return ret;
>         return count;
> --
