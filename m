From: keith.busch@intel.com (Keith Busch)
Date: Tue, 18 Dec 2018 10:26:46 -0700
Subject: [PATCH v4 2/2] trace nvme submit queue status
In-Reply-To: <20181218045138.4282-2-yupeng0921@gmail.com>
References: <20181218045138.4282-1-yupeng0921@gmail.com>
 <20181218045138.4282-2-yupeng0921@gmail.com>
Message-ID: <20181218172645.GB13768@localhost.localdomain>

On Mon, Dec 17, 2018@08:51:38PM -0800, yupeng wrote:
> +TRACE_EVENT(nvme_sq,
> +	TP_PROTO(void *rq_disk, int qid, int sq_head, int sq_tail),
> +	TP_ARGS(rq_disk, qid, sq_head, sq_tail),
> +	TP_STRUCT__entry(
> +		__array(char, disk, DISK_NAME_LEN)
> +		__field(int, qid)
> +		__field(int, sq_head)
> +		__field(int, sq_tail)
> +	),
> +	TP_fast_assign(
> +		__assign_disk_name(__entry->disk, rq_disk);
> +		__entry->qid = qid;
> +		__entry->sq_head = sq_head;
> +		__entry->sq_tail = sq_tail;
> +	),
> +	TP_printk("nvme: %s qid=%d head=%d tail=%d",
> +		__print_disk_name(__entry->disk),

No need for a space after the %s. __print_disk_name already appends a
space if there's a disk name, and we don't want the extra space if there
isn't one. Also, every other nvme trace has a ',' after each entry. Not
a big deal, just minor format consistency.
