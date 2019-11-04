Return-Path: <SRS0=VSZw=Y4=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0EF3CA9EC9
	for <linux-nvme@archiver.kernel.org>; Mon,  4 Nov 2019 22:57:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6FB6420663
	for <linux-nvme@archiver.kernel.org>; Mon,  4 Nov 2019 22:57:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="If7Hkdl8";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="y8+BFN97"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FB6420663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=7PVRQAXgItz2e0MzvwRRnD8rA4RfrlnNQzIEkAGgKTM=; b=If7Hkdl8y+4Ngm
	1FOTSOgXF0k1qqGgwHaL25CH99ymBW2NjTP+XhxIn0TTUDQEs9k1j7qZD0hLIcd11pRDM8KT+jtM7
	rjBBpVtPViPRzOiHDhK/JSI2Zyp3OVZqdJ/XGRqx98I3Cd8NF//FRJgntHxDv1jLDRWu5gaUF7dvg
	R8OkhavFKpiF0ZoHebykiMs0T7Oi+krV83nLFJ2DZgS1PW15Qd9YCCXpWdLt5gKlafuPeet/RLrMK
	OtSfuMtnbXH9I09lJbGPGqrt7pdl39nIULechPVIoJTKVFP9aerqdWN30tteLIZKQh+lRAnE75Pit
	mcKYFeonmeaj8cpIAcgQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iRlHc-00088k-Hj; Mon, 04 Nov 2019 22:57:12 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iRlHZ-00088M-3h
 for linux-nvme@lists.infradead.org; Mon, 04 Nov 2019 22:57:10 +0000
Received: from redsun51.ssa.fujisawa.hgst.com (unknown [199.255.47.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id C6BAB20663;
 Mon,  4 Nov 2019 22:57:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1572908228;
 bh=CW40oj6RN9mMVkdvaRHQAu+yvUjHH2qVAZH3wztExdw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=y8+BFN979kPnLNooRgnKz1wlX1d5DoX/U63h0q0Ikyhha0wtk/bcAbtQMavo3jmsQ
 Yfl0UtHbc6EChONCINrpF6q1iPsxxM0KhM2AQrKtFDusDqrtMy/przDcaGQI+ElwFc
 saZ/cgucbLgcEtISiNOlAXIRdZiZ3TldCUp65NvE=
Date: Tue, 5 Nov 2019 07:57:05 +0900
From: Keith Busch <kbusch@kernel.org>
To: wenxiong@linux.vnet.ibm.com
Subject: Re: [PATCH] nvme-cli: improvment critical warning format
Message-ID: <20191104225705.GB21282@redsun51.ssa.fujisawa.hgst.com>
References: <1572895699-3096-1-git-send-email-wenxiong@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1572895699-3096-1-git-send-email-wenxiong@linux.vnet.ibm.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191104_145709_181369_1E4AD2CC 
X-CRM114-Status: UNSURE (   8.00  )
X-CRM114-Notice: Please train this message.
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
Cc: keith.busch@intel.com, linux-nvme@lists.infradead.org, wenxiong@us.ibm.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, Nov 04, 2019 at 01:28:19PM -0600, wenxiong@linux.vnet.ibm.com wrote:
> +		json_object_add_value_int(root,"   [0:0]:Available Spare", smart->critical_warning & 0x01);
> +		json_object_add_value_int(root,"   [1:1]:Temp. Threshold", (smart->critical_warning & 0x02) >> 1);
> +		json_object_add_value_int(root,"   [2:2]:NVM subsystem Reliability", (smart->critical_warning & 0x04) >> 2);
> +		json_object_add_value_int(root,"   [3:3]:Read-only", (smart->critical_warning & 0x08) >> 3);
> +		json_object_add_value_int(root,"   [4:4]:Volatile mem. backup failed", (smart->critical_warning & 0x10) >> 4);
> +		json_object_add_value_int(root,"   [5:5]:Persistent Mem. RO", (smart->critical_warning & 0x20) >> 5);

That doesn't look like a very friendly json field name. Isn't the ':' a
special character?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
