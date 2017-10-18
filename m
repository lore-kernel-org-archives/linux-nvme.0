From: jsmart2021@gmail.com (James Smart)
Date: Wed, 18 Oct 2017 09:45:42 -0700
Subject: [PATCH v2] nvmet: protect sqhd update by a lock
In-Reply-To: <20171018072343.GA13666@infradead.org>
References: <20171016151820.14766-1-jsmart2021@gmail.com>
 <20171017064306.GA16133@infradead.org>
 <65999d52-2f65-2d9c-4cc4-db9d17fd9cab@broadcom.com>
 <20171018072343.GA13666@infradead.org>
Message-ID: <3ac0e8f3-69f1-e147-6221-809d68cb1ccf@gmail.com>

On 10/18/2017 12:23 AM, Christoph Hellwig wrote:
> do {
> 		old_sqhd = req->sq->sqhd;
> 		new_sqhd = (old + 1) % req->sq->size;
> 	} while (cmpxchg(&req->sq->sqhd, old_sqhd, new_sqhd) != old_sqhd);

sweet. does look good.

I'll repost as v3, but with an ammended title

-- james
