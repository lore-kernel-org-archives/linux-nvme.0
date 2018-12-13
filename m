From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 13 Dec 2018 07:49:42 -0800
Subject: [PATCH v2 6/6] nvme-multipath: disable polling for underlying
 namespace request queue
In-Reply-To: <20181213083157.GD869@lst.de>
References: <20181213063819.13614-1-sagi@grimberg.me>
 <20181213063819.13614-7-sagi@grimberg.me> <20181213083157.GD869@lst.de>
Message-ID: <4f3f213e-9042-5963-d47d-0ee501bf94fa@grimberg.me>


> +	if (!test_bit(QUEUE_FLAG_POLL, &q->queue_flags))
> +		bio->bi_opf &= ~REQ_HIPRI;
> +

Maybe we can simply check (q->queue_flags & (1 << QUEUE_FLAG_POLL)) and
avoid the extra atomic operation in the host path?

Would it make sense?
