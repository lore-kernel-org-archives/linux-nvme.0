From: jianchao.w.wang@oracle.com (jianchao.wang)
Date: Mon, 5 Feb 2018 10:26:03 +0800
Subject: [PATCH 2/6] nvme-pci: fix the freeze and quiesce for shutdown and
 reset case
In-Reply-To: <20180202182413.GH24417@localhost.localdomain>
References: <1517554849-7802-1-git-send-email-jianchao.w.wang@oracle.com>
 <1517554849-7802-3-git-send-email-jianchao.w.wang@oracle.com>
 <20180202182413.GH24417@localhost.localdomain>
Message-ID: <d93d115b-bdb1-24c0-71be-72f1b7563e5a@oracle.com>

Hi Keith

Thanks for your kindly response.

On 02/03/2018 02:24 AM, Keith Busch wrote:
> On Fri, Feb 02, 2018@03:00:45PM +0800, Jianchao Wang wrote:
>> Currently, request queue will be frozen and quiesced for both reset
>> and shutdown case. This will trigger ioq requests in RECONNECTING
>> state which should be avoided to prepare for following patch.
>> Just freeze request queue for shutdown case and drain all the resudual
>> entered requests after controller has been shutdown.

> Freezing is not just for shutdown. It's also used so
> blk_mq_update_nr_hw_queues will work if the queue count changes across
> resets.
blk_mq_update_nr_hw_queues will freeze the queue itself. Please refer to.
static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
							int nr_hw_queues)
{
	struct request_queue *q;

	lockdep_assert_held(&set->tag_list_lock);

	if (nr_hw_queues > nr_cpu_ids)
		nr_hw_queues = nr_cpu_ids;
	if (nr_hw_queues < 1 || nr_hw_queues == set->nr_hw_queues)
		return;

	list_for_each_entry(q, &set->tag_list, tag_set_list)
		blk_mq_freeze_queue(q);

	set->nr_hw_queues = nr_hw_queues;
	blk_mq_update_queue_map(set);
	list_for_each_entry(q, &set->tag_list, tag_set_list) {
		blk_mq_realloc_hw_ctxs(set, q);
		blk_mq_queue_reinit(q);
	}

	list_for_each_entry(q, &set->tag_list, tag_set_list)
		blk_mq_unfreeze_queue(q);
}

Thanks
Jianchao
