From: bjorn.helgaas@gmail.com (Bjorn Helgaas)
Date: Mon, 31 Dec 2018 15:24:55 -0600
Subject: [PATCH V2 3/3] nvme pci: introduce module parameter of
 'default_queues'
In-Reply-To: <20181229032650.27256-4-ming.lei@redhat.com>
References: <20181229032650.27256-1-ming.lei@redhat.com>
 <20181229032650.27256-4-ming.lei@redhat.com>
Message-ID: <CABhMZUVU-XcvBC9OjNw9=4gsmspy+Bc4urkb5fSo-7JeDO9m=Q@mail.gmail.com>

On Fri, Dec 28, 2018@9:27 PM Ming Lei <ming.lei@redhat.com> wrote:
>
> On big system with lots of CPU cores, it is easy to consume up irq
> vectors by assigning defaut queue with num_possible_cpus() irq vectors.
> Meantime it is often not necessary to allocate so many vectors for
> reaching NVMe's top performance under that situation.

s/defaut/default/

> This patch introduces module parameter of 'default_queues' to try
> to address this issue reported by Shan Hai.

Is there a URL to this report by Shan?

Is there some way you can figure this out automatically instead of
forcing the user to use a module parameter?

If not, can you provide some guidance in the changelog for how a user
is supposed to figure out when it's needed and what the value should
be?  If you add the parameter, I assume that will eventually have to
be mentioned in a release note, and it would be nice to have something
to start from.

> Reported-by: Shan Hai <shan.hai at oracle.com>
> Cc: Shan Hai <shan.hai at oracle.com>
> Cc: Keith Busch <keith.busch at intel.com>
> Cc: Jens Axboe <axboe at fb.com>
> Signed-off-by: Ming Lei <ming.lei at redhat.com>
> ---
>  drivers/nvme/host/pci.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 584ea7a57122..17a261e7f941 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -81,6 +81,12 @@ static const struct kernel_param_ops queue_count_ops = {
>         .get = param_get_int,
>  };
>
> +static int default_queues;
> +module_param_cb(default_queues, &queue_count_ops, &default_queues, 0644);
> +MODULE_PARM_DESC(default_queues,
> +       "Number of queues to use DEFAULT queue type. If not set, "
> +       "num_possible_cpus() will be used.");
> +
>  static int write_queues;
>  module_param_cb(write_queues, &queue_count_ops, &write_queues, 0644);
>  MODULE_PARM_DESC(write_queues,
> @@ -254,7 +260,9 @@ static inline void _nvme_check_size(void)
>
>  static unsigned int max_io_queues(void)
>  {
> -       return num_possible_cpus() + write_queues + poll_queues;
> +       int def_io_queues = default_queues ?: num_possible_cpus();
> +
> +       return def_io_queues + write_queues + poll_queues;
>  }
>
>  static unsigned int max_queue_count(void)
> --
> 2.9.5
>
>
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme
