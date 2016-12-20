From: hch@infradead.org (Christoph Hellwig)
Date: Mon, 19 Dec 2016 22:17:44 -0800
Subject: [PATCH v3 4/5] nvme: Implement resume_from_suspend and SED
 Allocation code.
In-Reply-To: <20161219222311.GA2056@sbauer-Z170X-UD5>
References: <1482176149-2257-1-git-send-email-scott.bauer@intel.com>
 <1482176149-2257-5-git-send-email-scott.bauer@intel.com>
 <20161219215954.GB10634@localhost.localdomain>
 <20161219222311.GA2056@sbauer-Z170X-UD5>
Message-ID: <20161220061744.GB4765@infradead.org>

On Mon, Dec 19, 2016@03:23:12PM -0700, Scott Bauer wrote:
> I went back and reviewed the spec 1.2.1:
> 
> http://www.nvmexpress.org/wp-content/uploads/NVM_Express_1_2_1_Gold_20160603.pdf
> Section 5.18 (page 140->141)
> 
> Describes the security send command type and it doesn't have any reference of
> a namespace ID. Anecdotally, I just removed the ns->ns_id line from the code and
> everything still works as intended. Is there another portion of the spec or errata
> that requires ns_id? (I can't access 1.2.1 errta the link doesn't work).

As far as I can tell Security Send / Receive has always been intended to
apply to the whole controller, even if that's something I would not
personally think is a good idea.
