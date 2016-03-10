From: keith.busch@intel.com (Keith Busch)
Date: Thu, 10 Mar 2016 15:07:46 +0000
Subject: [PATCH] nvme: avoid cqe corruption when update at the same
 time as read
In-Reply-To: <20160310143650.GA8689@infradead.org>
References: <1963234885.1121305.1457109031908.JavaMail.zimbra@kalray.eu>
 <1380738962.1128342.1457162595145.JavaMail.zimbra@kalray.eu>
 <20160309170846.GA14926@infradead.org>
 <881149974.3314758.1457608128188.JavaMail.zimbra@kalray.eu>
 <20160310143650.GA8689@infradead.org>
Message-ID: <20160310150745.GA23087@localhost.localdomain>

On Thu, Mar 10, 2016@06:36:50AM -0800, Christoph Hellwig wrote:
> On Thu, Mar 10, 2016@12:08:48PM +0100, Marta Rybczynska wrote:
> > Looks like a good refactoring to me. However, it seems to me that in
> > nvme_cqe_valid we should be checking for phase, not for head.
> 
> Yeah, this doesn't work as-is.  I still think that non-obvious
> check should be split out into something.  Maybe just:
> 
> static inline bool nvme_cqe_valid(struct nvme_queue *nvmeq, u16 head, u16 phase)
> {
> 	return (le16_to_cpu(nvmeq->cqes[head].status) & 1) == phase;
> }

Looks good.

The code had copied the CQE since the initial commit, so just want to
mention a torn CQE read could cause real trouble only if the Phase is
out of sync with the Command ID. These are in the same DWORD and many
(most?) archs compile to read those 4-bytes atomically.

We certainly can't rely on that, so this is a good change.
