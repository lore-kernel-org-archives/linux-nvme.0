From: keith.busch@intel.com (Keith Busch)
Date: Mon, 22 Jan 2018 10:32:39 -0700
Subject: Why NVMe MSIx vectors affinity set across NUMA nodes?
In-Reply-To: <CAKTKpr59h-PXz60BNkx4_80gHyeFawcJW17dt9Y5VRrmHRsSQA@mail.gmail.com>
References: <CAKTKpr6V=UPtRRApvQ_TAEuRQB8qqgvDmaaXFjch4wpZUqoAfw@mail.gmail.com>
 <20180122171437.GL12043@localhost.localdomain>
 <CAKTKpr59h-PXz60BNkx4_80gHyeFawcJW17dt9Y5VRrmHRsSQA@mail.gmail.com>
Message-ID: <20180122173239.GM12043@localhost.localdomain>

On Mon, Jan 22, 2018@10:52:59PM +0530, Ganapatrao Kulkarni wrote:
> 
> There are 31 MSIx vectors getting initialised(one per NVMe queue) and
> out of it, 0-15 are getting
> affinity set to node 0 CPUs and vectors 16-30 are getting set to node 1.
> My question is, why not set affinity to all vectors from same node
> CPUs, what was need to use flag PCI_IRQ_AFFINITY?

I'm sorry, but I am not able to parse this question.
