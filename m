From: stephen.bates@microsemi.com (Stephen Bates)
Date: Tue, 5 Apr 2016 18:07:19 +0000
Subject: [PATCH 0/2] Block: Give option to force io polling
In-Reply-To: <20160405172749.GB31055@infradead.org>
References: <1459455554-2794-1-git-send-email-jonathan.derrick@intel.com>
 <20160405123832.GA27788@infradead.org>
 <20160405155453.GB12625@localhost.localdomain>
 <20160405172749.GB31055@infradead.org>
Message-ID: <D87A37E7A4AA544D853031D9A919C70B168CB351@avsrvexchmbx2.microsemi.net>

> > I think it's more about providing opt-in control to make the
> > low-latency benefit reachable to users with existing programs.
> 
> What program benefits from unconditional polling for all I/O on a given
> device?

End users  who want to avail of the polling benefits for low latency NVMe devices without having to resort to rewriting their code would like to see something like what Jon is proposing. As I understand it this could be polling control per queue not per device but I can see caching applications where polling for the whole NVMe device would be desirable.

Stephen
