From: hch@infradead.org (Christoph Hellwig)
Date: Tue, 5 Apr 2016 10:27:49 -0700
Subject: [PATCH 0/2] Block: Give option to force io polling
In-Reply-To: <20160405155453.GB12625@localhost.localdomain>
References: <1459455554-2794-1-git-send-email-jonathan.derrick@intel.com>
 <20160405123832.GA27788@infradead.org>
 <20160405155453.GB12625@localhost.localdomain>
Message-ID: <20160405172749.GB31055@infradead.org>

On Tue, Apr 05, 2016@03:54:54PM +0000, Keith Busch wrote:
> I think it's more about providing opt-in control to make the low-latency
> benefit reachable to users with existing programs.

What program benefits from unconditional polling for all I/O on a given
device?
