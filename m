From: keith.busch@intel.com (Keith Busch)
Date: Tue, 13 Feb 2018 07:47:28 -0700
Subject: [PATCH 1/3] nvme-pci: Fix timeouts in connecting state
In-Reply-To: <2a055b6d-15d5-1fb1-f7db-47023c2cf8d1@oracle.com>
References: <20180209174127.7224-1-keith.busch@intel.com>
 <ec9b47c4-3c83-6f00-bf2d-8eae5484a649@oracle.com>
 <20180212141818.GA16255@localhost.localdomain>
 <58a6237f-53ab-c0bf-2739-08fc3a45cdd1@oracle.com>
 <2a055b6d-15d5-1fb1-f7db-47023c2cf8d1@oracle.com>
Message-ID: <20180213144728.GC20962@localhost.localdomain>

On Tue, Feb 13, 2018@10:33:03AM +0800, jianchao.wang wrote:
> On 02/13/2018 10:21 AM, jianchao.wang wrote:
> > This patch could not fix the issue totally, it will not work well with
> > your 3rd patch
> 
> s/with/without

The first patch fixes a regression introduced in this merge window and
gets us back to functionality we had before. The third patch fixes a
theoretical issue that AFAIK has never actually happened in real life.
