Return-Path: <SRS0=uU0g=D3=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33C86C4363A
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Oct 2020 17:56:55 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 709972223C
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Oct 2020 17:56:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="tqL9sTwx";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="gC+UW1q0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 709972223C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Yv3+MbWPhdz5Heo/Btk78vkAYnpXRO0vv4TGKubWr4A=; b=tqL9sTwxzfLXO7AZUAlzgX4rx
	4GyPv162meY3Kh96LN2ecMpNMF2Dw6emrLWctLNCN0P2jCKTT3wZ+A/p4JaPbVwWnjkfSOfqiQ8S9
	1Q/6QKodA37ILcPe2fIGaQz6rVTAF0SmpAqqIAorZh7wEmskTmTJiwrqzhiTIq2dba3P3JL/sj2EC
	ze2NHphOFum9oVl0YNg/Q85j3ZGdN3hf4HqSwWeiKcxYZw8Fc6EKut0lfqNpF0PbuKRdX8oh1IZLP
	NWjs+18nU7BCuHmAU63acBs7GvO3eZKoKbvQPyqQ5JOKLrCi9ZmN7EgBO5iln8RELY+nWUB1aAAp/
	aVGuvNPgg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kUvsR-0001Jr-8n; Tue, 20 Oct 2020 17:56:51 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kUvsO-0001JL-GG
 for linux-nvme@lists.infradead.org; Tue, 20 Oct 2020 17:56:49 +0000
Received: from dhcp-10-100-145-180.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 8C4FB2223C;
 Tue, 20 Oct 2020 17:56:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1603216607;
 bh=Uv9NS3DnWKeC9bJMJZsWF8bL0jCe1/kzN0vVYZ/siho=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=gC+UW1q0e7zbibE9ebgR4IczIpKQI2aOGvj1DW9NI3qa9WVQhuQwy0CWnWynjMN0E
 3A6uYcFHj/m4q1AF0N3H9D/2EoLnovXP+r1LnQol2lEtQ1ZtXGxP916qJaveSU3HkO
 llXIIdtZ8LMAp99G3QE4p7jKPNmZ4phe+putINqs=
Date: Tue, 20 Oct 2020 10:56:44 -0700
From: Keith Busch <kbusch@kernel.org>
To: Daniel Wagner <dwagner@suse.de>
Subject: Re: NVMe CLI Version Tag
Message-ID: <20201020175644.GA1438267@dhcp-10-100-145-180.wdc.com>
References: <BYAPR04MB5656B49BFE47211B3A2F1748EA1F0@BYAPR04MB5656.namprd04.prod.outlook.com>
 <20201020175017.2avzkm2bwyeg2t3a@beryllium.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201020175017.2avzkm2bwyeg2t3a@beryllium.lan>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201020_135648_698192_2ADD47BA 
X-CRM114-Status: GOOD (  13.11  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Sean Brownlow <sean.brownlow@wdc.com>,
 Randall Bates <randall.bates@wdc.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Jeffrey Lien <Jeff.Lien@wdc.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Oct 20, 2020 at 07:50:17PM +0200, Daniel Wagner wrote:
> On Tue, Oct 20, 2020 at 03:52:25PM +0000, Jeffrey Lien wrote:
> > I'd like to request that the nvme cli version be updated to 1.13 and
> > then tagged.   It's been 4 months since it was last changed and
> > tagged.
> 
> FWIW, I would also appreciate to have a fresh release of nvme-cli.

Sure thing, I'll just run it through some sanity tests this afternoon
and set a new tag this evening if everything checks out.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
