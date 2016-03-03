From: keith.busch@intel.com (Keith Busch)
Date: Thu, 3 Mar 2016 14:17:00 +0000
Subject: Tested LBA size ?
In-Reply-To: <56D80AB7.4040607@ip-maker.com>
References: <56D723B9.6030004@ip-maker.com>
 <20160303084729.GA1280@infradead.org>
 <56D80AB7.4040607@ip-maker.com>
Message-ID: <20160303141659.GB1004@localhost.localdomain>

On Thu, Mar 03, 2016@10:58:15AM +0100, Olivier Mallinger - IP Maker wrote:
> By VM, you mean "Virtual Machine" ?

VM -- Virtual Memory

> Can I conclude that VM page size is generally 4kB today ? an you
> confirm that ?

Probably. 4k is the most common VM page size. It's the only supported size 
on x86. If using something else, YMMV. To confirm, run:

  # getconf PAGESIZE
