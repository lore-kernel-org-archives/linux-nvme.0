From: sagi@grimberg.me (Sagi Grimberg)
Date: Tue, 3 Oct 2017 01:38:21 +0300
Subject: [PATCH] nvmet_fc: Reduce work_q count
In-Reply-To: <20171001083932.GA878@infradead.org>
References: <20170927040958.5981-1-jsmart2021@gmail.com>
 <90b9711d-e279-443d-1693-dad24524cc74@grimberg.me>
 <e86009d5-2ca6-8de3-d142-781724bf00d8@gmail.com>
 <20171001083932.GA878@infradead.org>
Message-ID: <0fd8f917-5bfd-4d07-4c2e-6306e6a263f7@grimberg.me>


> And that's exactly what plain queue_work will give you.  If it doesn't
> do exactly what your open code logic does it has a bug that needs to
> be fixed.

I also think you are missing a put_cpu().
