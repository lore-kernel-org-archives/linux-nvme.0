Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA05DC0218D
	for <linux-nvme@archiver.kernel.org>; Fri, 31 Jan 2025 09:32:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Aoy2sRRW/FJEO5UC6j6TFm2ADEMYW8P+uISt1al7jVc=; b=kvUYfvqnlmGVPzWq8R/nNzwG3A
	gBSEARSzTVRjhjnWq25Tc6uVycoWPsdSHGnPSnC9oG1G/GRiODSOpzu2mut6garIuF/RJzgA59i9N
	Aas1rugxpUsPH3jX64QuNtODdZAM8IWWVASRXhN6uPNd9hc+j/P/pYOAI/E3X1tMp0Ejb8enMdnaE
	qACa3YMZkttj0yvq1ytt8V2WEvWbI6mS9zFTmAcKLFr53yUYN5FH5ihE8VY3eGpkNa0RXsvFMfdQe
	VXC9kCfSDydvjb84uLLhSTuKdcQ645uw4tvJ0ZANin1f5huOn2uZErx9Zuz4w7qZAogp3KXUCHKE/
	MMz7biwg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tdnNd-0000000AJkQ-2qOZ;
	Fri, 31 Jan 2025 09:32:05 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tdnNb-0000000AJjt-15Bc;
	Fri, 31 Jan 2025 09:32:03 +0000
Date: Fri, 31 Jan 2025 01:32:03 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Daniel Wagner <dwagner@suse.de>
Cc: linux-nvme@lists.infradead.org,
	Mohamed Khalfella <mkhalfella@purestorage.com>,
	Christoph Hellwig <hch@infradead.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	John Meneghini <jmeneghi@redhat.com>,
	Hannes Reinecke <hare@suse.de>,
	Randy Jennings <randyj@purestorage.com>,
	Keith Busch <kbusch@kernel.org>, lsf-pc@lists.linux-foundation.org
Subject: Re: [LSF/MM/BPF TOPIC] TP4129 KATO correctoins and clarification
Message-ID: <Z5yYk7vHIhMfiPz1@infradead.org>
References: <63af907d-9cdd-4956-9978-4e77389b1716@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <63af907d-9cdd-4956-9978-4e77389b1716@suse.de>
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

On Fri, Jan 31, 2025 at 10:24:31AM +0100, Daniel Wagner wrote:
> Hi,
> 
> The KATO handling in the spec got updated via the TP4129. In short it
> mandatas that failing requests should be delayed by some value before
> retried on a different path.

TP4129 is broken and the TWG has been told that.  There is absolutely no
point in either implementing it or rehashing the discussion over and
over again.  Concentrate on making 8028 useful instead.  And if you want
a discussion, "why do people people push stupid things though the
NVMe TWG and then comaplain later about the lack of implementations"
might be more useful.

