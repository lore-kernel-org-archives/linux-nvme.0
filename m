From: keith.busch@intel.com (Keith Busch)
Date: Tue, 20 Dec 2016 10:49:16 -0500
Subject: [PATCH v3 4/5] nvme: Implement resume_from_suspend and SED
 Allocation code.
In-Reply-To: <20161220061744.GB4765@infradead.org>
References: <1482176149-2257-1-git-send-email-scott.bauer@intel.com>
 <1482176149-2257-5-git-send-email-scott.bauer@intel.com>
 <20161219215954.GB10634@localhost.localdomain>
 <20161219222311.GA2056@sbauer-Z170X-UD5>
 <20161220061744.GB4765@infradead.org>
Message-ID: <20161220154916.GC10634@localhost.localdomain>

On Mon, Dec 19, 2016@10:17:44PM -0800, Christoph Hellwig wrote:
> As far as I can tell Security Send / Receive has always been intended to
> apply to the whole controller, even if that's something I would not
> personally think is a good idea.

NVMe security commands required the namespace ID since the very
beginning. It's currently documented in figure 42 of section 5,
"Namespace Identifier Used" column.
