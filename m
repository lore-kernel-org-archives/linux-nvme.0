Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06AA1CF34A9
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Oct 2024 14:41:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=68S4dQT1KUyzjUvT5yNR+qXy6ifWI0QZMMCDLS9H9WU=; b=i4JO/astPpzpeYQBEfgt1NcXKA
	YVog1lhWNuLhfHC2Dw5IlNV41XvtQcTHruN/KeHp7BxEHaqF6AwVu7w5c1QK+LTimS95cg++EpzYx
	ESdmY6ZACODsT9WnPJ4Y9sVkSDyipzIdkCPHtc0HcrilXBc/5B058l8CbJ1fbcphUAhpruqfvdRPN
	BoVO5KacK5HQOEIPCsVasr3MyP+LcnW1u7WMqAgb+lIjUrhjtUbmdFr8CFS2g/lVUsjAjBnfrpwiE
	/BzrV9o2j56xk0FHq1agp7Drm6Kf+NbiUzQLJ6ahmIIInneOEXjFjId8rtVfPgTyMbFBwYabDSIst
	sNBy1/Sg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1swN14-00000009QdZ-12uw;
	Thu, 03 Oct 2024 14:41:18 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1swN0y-00000009Qaw-0eyu
	for linux-nvme@lists.infradead.org;
	Thu, 03 Oct 2024 14:41:13 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id BA49E227A8E; Thu,  3 Oct 2024 16:41:06 +0200 (CEST)
Date: Thu, 3 Oct 2024 16:41:06 +0200
From: Christoph Hellwig <hch@lst.de>
To: Greg Joyce <gjoyce@linux.ibm.com>
Cc: Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
	kbusch@kernel.org, axboe@fb.com, sagi@grimberg.me, hare@suse.de,
	dwagner@suse.de, msuchanek@suse.de, jonathan.derrick@linux.dev,
	okozina@redhat.com, nilay@linux.ibm.com
Subject: Re: [PATCH 1/1] nvme: retry security commands if media not ready
Message-ID: <20241003144106.GA24422@lst.de>
References: <20240930164845.8406-1-gjoyce@linux.ibm.com> <20240930164845.8406-2-gjoyce@linux.ibm.com> <20241002081633.GA22436@lst.de> <dbfd87e4900bea3a28ac46f5abcfb39ef2c13fc1.camel@linux.ibm.com> <20241003124345.GA16754@lst.de> <3876a795bbaa8cef46ed0cb84f8eeccc5462f075.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3876a795bbaa8cef46ed0cb84f8eeccc5462f075.camel@linux.ibm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241003_074112_360836_5003E5B0 
X-CRM114-Status: GOOD (  13.22  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Oct 03, 2024 at 08:30:21AM -0500, Greg Joyce wrote:
> Thanks. I think that leads me to ask a larger question. If we always
> wait until media ready,

We don't generally wait - the namespaces only become online when they
are ready, but otherwise we should be up.  Unfortunately the technical
working group allowed some admin command to return media not ready,
probably to shoe horn existing implementation.  But this generally
is a bad quality of implementation and there is no good reason for it
if the little bit of media used by these comes from a separate pool
that doesn't take as long to recover.  Or in other words, if you see
this error someonone at IBM messed up writing their purchase spec..


