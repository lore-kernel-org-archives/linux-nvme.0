From: minwoo.im.dev@gmail.com (Minwoo Im)
Date: Sun, 12 May 2019 22:09:09 +0900
Subject: [PATCH] nvme-pci: Fix queue_count to consider nr_possible_cpu
In-Reply-To: <20190508071456.GA21604@lst.de>
References: <20190504113923.32316-1-minwoo.im.dev@gmail.com>
 <20190508071456.GA21604@lst.de>
Message-ID: <0ea5caaf-be54-d0d6-49f7-a47de00711fd@gmail.com>


> This just looks weird.  If we ant to limit the number why not
> get rid of all these param_ops stuff and just verify the
> number in nvme_calc_irq_sets without all that boilerplate code?
> 

Hi Christoph,

Thanks for your review on this.  Module parameters which are with 
param_ops are currently the following two things, as you know:
	(1) write_queues
	(2) poll_queues

If those two things are used in nvme_setup_irqs() and 
nvme_calc_irq_sets() only, then we can remove param_ops things and go 
like what you mentioned.  However, before preparing irq sets of them, 
the following function is invoked to find out proper nr_io_queues by 
referring those modules params.

static unsigned int max_io_queues(void)
{
	return num_possible_cpus() + write_queues + poll_queues;
}

if max_io_queues() gives nr_io_queues in a too large value, we need to 
do something to fit it to proper value in nvme_setup_irqs() or 
nvme_calc_irq_sets() which might be also boilerplate code.

Please see the below code and give your comment on it.  I guess it also 
looks not that really good :(

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 2a8708c9ac18..28e43627da5a 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2073,6 +2073,16 @@ static int nvme_setup_irqs(struct nvme_dev *dev, 
unsigned int nr_io_queues)
  	 * Poll queues don't need interrupts, but we need at least one IO
  	 * queue left over for non-polled IO.
  	 */
+	if (poll_queues > num_possible_cpus()) {
+		poll_queues = num_possible_cpus();
+		nr_io_queues = max_io_queues();
+	}
+
+	if (write_queues > num_possible_cpus()) {
+		write_queues = num_possible_cpus();
+		nr_io_queues = max_io_queues();
+	}
+
  	this_p_queues = poll_queues;
  	if (this_p_queues >= nr_io_queues) {
  		this_p_queues = nr_io_queues - 1;


Thanks,
