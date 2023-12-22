Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C8FCC41535
	for <linux-nvme@archiver.kernel.org>; Fri, 22 Dec 2023 16:06:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2FDOW+3+TDRLXOzIEQkltc11UaDDT4Rh+Z5GwJAlFHo=; b=fGVPQWFvm9qLdNM4D0vy8970S/
	gKb82MDysTVz0Tm/b0pOJ7NaVXXNUO57TUubzLWjr6xjgz1TtmaDM+F3VjOk0Qu4LV7f4lzo9FANk
	yvolQssOYRLfIudyTpKnckbih80oCiqEfeJMMZJy2GkD18dCvLlZHpK8FSFxeOrDLvCG8QJRpKAqD
	PYKTi4akjDOlgst5mccfAGlbD9hNe859ovrhouegyJOWcL8Sn9v9Jr0pq+BXccTM571xtfcW8nOmF
	dMfjw1A/WF6nVyijEBPbGnvcWHz83GrHJmNReo6PcS5y5KvYsjfvdcEPNII007B5550TxkdNAwA1u
	QH2YzflQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rGi2R-006KYr-1I;
	Fri, 22 Dec 2023 16:06:15 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rGi2P-006KYc-2I
	for linux-nvme@bombadil.infradead.org;
	Fri, 22 Dec 2023 16:06:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=2FDOW+3+TDRLXOzIEQkltc11UaDDT4Rh+Z5GwJAlFHo=; b=M7xlX1MrgGdcrlbmtcelj6k4Uu
	Ro1Ax1OdCds0mPQw1Cv++MOErDQGGRZuLTh/VlDKfbzgBHjKaeTYDwX/Swk2lMRAJwEHuaMHZRx8W
	lgE9rk8Yrs+fqAp0eJg0nOFsyXwoJTNq9zwOfnEMV+jnsJXNpmxwN9RuQa7mvEUvHl56MTTNSg5Vz
	ibdkQnZAi3n+/DStTbBcQ8dw/MsZ7u+qqYw5wAxEfZWEIPWtaEJC4aNFj52dYvAlQaLxp4hkOsUIq
	6CV/IwbKuoDHb1eaYtLIB8MibMEy4D2rC31iOv3CbuXnaDHktvytm1Fi1tBX4hfX4pItOsuXoEk2r
	wLfjKIcg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1rGi2K-008Qjo-Oi; Fri, 22 Dec 2023 16:06:08 +0000
Date: Fri, 22 Dec 2023 16:06:08 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Keith Busch <kbusch@kernel.org>
Cc: Viacheslav Dubeyko <slava@dubeyko.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Hannes Reinecke <hare@suse.de>, lsf-pc@lists.linuxfoundation.org,
	linux-mm@kvack.org, linux-block@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [LSF/MM/BPF TOPIC] Large block for I/O
Message-ID: <ZYWz8K98YUGf/VZp@casper.infradead.org>
References: <7970ad75-ca6a-34b9-43ea-c6f67fe6eae6@iogearbox.net>
 <4343d07b-b1b2-d43b-c201-a48e89145e5c@iogearbox.net>
 <03ebbc5f-2ff5-4f3c-8c5b-544413c55257@suse.de>
 <5c356222-fe9e-41b0-b7fe-218fbcde4573@acm.org>
 <BB694C7D-0000-4E2F-B26C-F0E719119B0C@dubeyko.com>
 <ZYWm_tMtfrKaNf3t@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZYWm_tMtfrKaNf3t@kbusch-mbp>
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

On Fri, Dec 22, 2023 at 08:10:54AM -0700, Keith Busch wrote:
> If the host really wants to write in small granularities, then larger
> block sizes just shifts the write amplification from the device to the
> host, which seems worse than letting the device deal with it.

Maybe?  I'm never sure about that.  See, if the drive is actually
managing the flash in 16kB chunks internally, then the drive has to do a
RMW which is increased latency over the host just doing a 16kB write,
which can go straight to flash.  Assuming the host has the whole 16kB in
memory (likely?)  Of course, if you're PCIe bandwidth limited, then a
4kB write looks more attractive, but generally I think drives tend to
be IOPS limited not bandwidth limited today?


