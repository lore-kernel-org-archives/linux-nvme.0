From: mb@lightnvm.io (Matias)
Date: Tue, 04 Aug 2015 13:58:32 +0200
Subject: [PATCH v6 0/5] Support for Open-Channel SSDs
In-Reply-To: <20150804113013.GC8395@infradead.org>
References: <1438082268-13496-1-git-send-email-mb@lightnvm.io>
 <20150804113013.GC8395@infradead.org>
Message-ID: <55C0A8E8.7040308@lightnvm.io>

On 08/04/2015 01:30 PM, Christoph Hellwig wrote:
> Hi Matias,
>
> the architecture looks fine to me.  Probab;y not worth merging until
> your have the multipage I/O sorted out and real hardware, or do you want
> to aim for fast inclusion?
>

Hi Christoph,

The multipage will come in v7. Javier has it flushed out, and we are 
just going through the last nitpicks on it.

I'll like to get it included. There is some out-of-tree work that is 
based on it, which requires that the kernel and the modules are compiled 
together. Having the core part in the kernel will be very helpful.

(resending to the lists. Forgot to put gmail in plain text mode)
