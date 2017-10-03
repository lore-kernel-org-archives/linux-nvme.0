From: jsmart2021@gmail.com (James Smart)
Date: Tue, 3 Oct 2017 12:40:40 -0700
Subject: [PATCH] nvmet_fc: Reduce work_q count
In-Reply-To: <20171001083932.GA878@infradead.org>
References: <20170927040958.5981-1-jsmart2021@gmail.com>
 <90b9711d-e279-443d-1693-dad24524cc74@grimberg.me>
 <e86009d5-2ca6-8de3-d142-781724bf00d8@gmail.com>
 <20171001083932.GA878@infradead.org>
Message-ID: <147c11f9-24cc-7328-80e9-409cbb0e9e46@gmail.com>

On 10/1/2017 1:39 AM, Christoph Hellwig wrote:
> On Sat, Sep 30, 2017@11:32:39AM -0700, James Smart wrote:
>> Because we're still trying to get cpu affinity on the connection resources
>> that will be shared by the io on the same queue.
> 
> And that's exactly what plain queue_work will give you.  If it doesn't
> do exactly what your open code logic does it has a bug that needs to
> be fixed.
> 
I don't understand how queuing work alone, which can go to any cpu 
(current preferred) helps with avoiding cross-cpu access to the same 
transport/lldd hw queue data structures.

But, as stated. A moot point now. I'll remove this whole IN_ISR, thus 
work_q item, shortly.

-- james
