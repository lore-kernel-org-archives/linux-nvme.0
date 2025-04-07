Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 803F8C369A3
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Apr 2025 16:28:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xPHlEBX0FyY5lCkumFbOsx+SzhtF7bCsHLR5aTLJXbo=; b=z9nZn0cp5rpdetT5VOjIaMYFbD
	kVAT5iR7FX/qpNnjiV0zp61wiHBb6E7SenS2naNxr2arcS5VgPPYAOEk0B7lSGv5kvQQG8EIcbraa
	Rog66IjhOPvwdq1eGVshh5NvnFsOgzJOyRj59Bb8Rm5jNRUaxFs+XBhEIWsAHlK40aSTDzBZK1w7t
	bzqJ5wxn0xkJeB1KFCG5V94g4dEAHq+tfmeynAYeJ7iXBlyJFfJbbSWSzew/wNlolPYm5C4LZ/ZGh
	6zWarpb4YAKnf1EzwAexieet8n0w0BGd5hi8ER0lZXjsUyj8zYhKSlNDWVxxVTFJvWGMfZzz699vA
	5/m9g9dQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u1pKY-00000001BZn-35rp;
	Mon, 07 Apr 2025 16:28:14 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u1njb-00000000nI0-1HLV
	for linux-nvme@lists.infradead.org;
	Mon, 07 Apr 2025 14:46:00 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id D98B568AFE; Mon,  7 Apr 2025 16:45:55 +0200 (CEST)
Date: Mon, 7 Apr 2025 16:45:55 +0200
From: Christoph Hellwig <hch@lst.de>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org, hch@lst.de,
	kbusch@kernel.org, hare@suse.de, sagi@grimberg.me,
	jmeneghi@redhat.com, axboe@kernel.dk, gjoyce@ibm.com
Subject: Re: [RFC PATCH 2/2] nvme-multipath: remove multipath module param
Message-ID: <20250407144555.GB12216@lst.de>
References: <20250321063901.747605-1-nilay@linux.ibm.com> <20250321063901.747605-3-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250321063901.747605-3-nilay@linux.ibm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250407_074559_484040_010761C7 
X-CRM114-Status: GOOD (  13.23  )
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

On Fri, Mar 21, 2025 at 12:07:23PM +0530, Nilay Shroff wrote:
> Remove the multipath module parameter from nvme-core and make native
> NVMe multipath support explicit. Since we now always create a multipath
> head disk node, even for single-port NVMe disks, when CONFIG_NVME_
> MULTIPATH is enabled, this module parameter is no longer needed to
> toggle the behavior.
> 
> Users who prefer non-native multipath must disable CONFIG_NVME_MULTIPATH
> at compile time.

Hmm, I actually missed that in the last patch.  I fear that is a huge
change people don't expect.  I suspect we need to make the creation
of the head node and the delayed removal an opt-in and not the default
to keep existing behavior.

