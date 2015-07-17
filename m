From: hch@infradead.org (Christoph Hellwig)
Date: Fri, 17 Jul 2015 02:30:07 -0700
Subject: [PATCH] NVMe: Reread partitions on metadata formats
In-Reply-To: <yq1380no8rg.fsf@sermon.lab.mkp.net>
References: <1436896668-27373-1-git-send-email-keith.busch@intel.com>
 <55A559B5.2000303@fb.com>
 <CAA9_cmc2Kb=XRwPpOijT+T_1-qfPH-h7LeM0AGSP6ZOW72MjwQ@mail.gmail.com>
 <55A6D251.9050801@fb.com>
 <alpine.LNX.2.00.1507152142070.15930@localhost.lm.intel.com>
 <20150716091957.GA18310@infradead.org>
 <yq1380no8rg.fsf@sermon.lab.mkp.net>
Message-ID: <20150717093007.GA4357@infradead.org>

On Thu, Jul 16, 2015@09:47:15PM -0400, Martin K. Petersen wrote:
> The flags, protection interval, tag size, etc. are per-device
> properties.

In which case we should just add them directly to the gendisk..
