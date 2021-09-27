Return-Path: <SRS0=w6YM=OR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B168BC433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Sep 2021 20:22:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7462960EB4
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Sep 2021 20:22:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7462960EB4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=JZigpB47ZVQlX416WKVdL67uwZmIbyvlOlvnytwAI94=; b=EcfpEw76tOODoC
	dpHA5ZK/1u6dlscD0jJ6D9HF7zjIcAcoLSS3ehZIzESy8WybtV5gLq0onieI6wGvVw+lZ6Yjq+Gzf
	X3JX7N7tLQvdIAmuEzPDht+n2OEJyIKTuv3RcSzhh8nviAN0zqOkUUImONHXa0aj/9RX1Lrxz6sND
	ZxN7Bvx4vB+Lm1C448Cuc0x69uVYcs8fbObdYa8LYgTXg82/w2dHgPc3i4pZVX851/q02Rd1O1OWm
	70bJwME3qMDzlaJ6+C9SaP9y27DPVlG8WyZrE505JiwWok+JfqTP5SGDN89DrFSO26gG7jQACLVfr
	8AA94JqQoZ0VedhR+w9g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mUx92-004AHF-4o; Mon, 27 Sep 2021 20:22:36 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mUx8z-004AGi-9N
 for linux-nvme@lists.infradead.org; Mon, 27 Sep 2021 20:22:34 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id A872660EBB;
 Mon, 27 Sep 2021 20:22:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1632774153;
 bh=TiVfs9TnTvt8NCzLeiBYwXiLkKQkqLvNw6cM0aafRmQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=NuaS82hMlyfzRiLxl1+QlDVAaOrFUD2USVD1vgrzM/UFk9XFwvKITMUdVr/ilwI21
 glILAemFDXvqlyAZUXouy2HC2jnLtkgfXfm44OCG2RwXAvpuQRZghIqA5gtp0LPioH
 0U0bG74joh+jQJpTNtZDVP4Qpx0vPAzJP15mljNEGdrprbXVjTfhruZDk+VF+Ta1UJ
 RycolObsaONHv1N/ahjgiD3nBzD9k/M97rvwbzE1zo4rnHRzp4TINQolfhLtlvQwhr
 KHrd3R1jj0h1QAWqSd6sqGNwFUvCDMRv38ca9aIvI3VeW+fs/d+eSdahx1enfMnL4u
 gfpZJ1At7t1Nw==
Date: Mon, 27 Sep 2021 13:22:30 -0700
From: Keith Busch <kbusch@kernel.org>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH nvme-cli] fabrics: restore discover_from_conf_file to
 actually work
Message-ID: <20210927202230.GC387558@dhcp-10-100-145-180.wdc.com>
References: <20210926182749.55191-1-sagi@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210926182749.55191-1-sagi@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210927_132233_370178_4E04777E 
X-CRM114-Status: UNSURE (   5.27  )
X-CRM114-Notice: Please train this message.
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Thank you, patch applied.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
