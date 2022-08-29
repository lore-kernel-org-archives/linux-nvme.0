Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF202ECAAD4
	for <linux-nvme@archiver.kernel.org>; Mon, 29 Aug 2022 09:07:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=L1RCi9/HsWsi9iNRczJuwc/4Yz3/v2SGn/dI0eia6qM=; b=fwNRDLKQA9j7jomk/U6ZWcVXUZ
	bW8VYTkcpnE5YauzRoTRHNzUfDFcPwS2FCoXgutBvxtWANiZcM59C8KOuIijvgbWnI9OJAeENjxZX
	auMTEgskTfxWmnZM3L75UOUwE9nuXbOufkh1PlvJEWesh/UgKkxUl1AbOCX+ozirD5ykb2XpVYbLg
	9UmGreFwlaOm9fG6s+sBE4zB4vDaRs5AGSpKd0pG34VzO0TJ6USBuVVdOiZD+fNq5LXa12SnxmBX4
	73xs176gE3Plc1Bmlssi+zVahN7n474z03N5vRXwmuHfyJv37acGwUucLmHE12MxEhnH6Xxv1faOX
	lKjCuA2g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oSajY-006Wrs-04; Mon, 29 Aug 2022 09:07:04 +0000
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oSajW-006Wpp-17
	for linux-nvme@lists.infradead.org; Mon, 29 Aug 2022 09:07:03 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C8AB122CC2;
	Mon, 29 Aug 2022 09:07:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1661764020; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L1RCi9/HsWsi9iNRczJuwc/4Yz3/v2SGn/dI0eia6qM=;
	b=LbiOstfLU2gfIiYjzvzc2lgIkVteazF7pHEnlJn6RCuO7q0VdNaFnEpcYpsbUP3ACO5EOr
	/+WBM58jXuyBVyF8fGlRs3xE2sWXjzU6+tZ+i/1JgTeGP4t+XhwsxlsULTnZ1OoRv9UZFL
	dXqZiTkm1plgWKo3HPabSJuQ19kBsb8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1661764020;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L1RCi9/HsWsi9iNRczJuwc/4Yz3/v2SGn/dI0eia6qM=;
	b=Qk9hki0wy6Yp2xlKfxAH6bDiSNiQ4moYV58qkPUmEXt8BgrKa/S7fNnNq/6+garolWQe50
	i8+NqS4mWgOwp2CA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B78AA1352A;
	Mon, 29 Aug 2022 09:07:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id Ul1DLLSBDGNwIAAAMHmgww
	(envelope-from <hare@suse.de>); Mon, 29 Aug 2022 09:07:00 +0000
Message-ID: <f8ee0fd3-45c2-7848-aa5a-6627c7672349@suse.de>
Date: Mon, 29 Aug 2022 11:07:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v3 0/3] Handle number of queue changes
Content-Language: en-US
To: Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org
Cc: Sagi Grimberg <sagi@grimberg.me>, Chao Leng <lengchao@huawei.com>
References: <20220829083856.1850-1-dwagner@suse.de>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20220829083856.1850-1-dwagner@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220829_020702_265734_AFE057EF 
X-CRM114-Status: GOOD (  10.63  )
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

On 8/29/22 10:38, Daniel Wagner wrote:
> Updated this series to a proper patch series with Hannes and Sagi's
> feedback addressed.
> 
> I tested this with nvme-tcp but due to lack of hardware the nvme-rdma
> is only compile tested.
> 

One does wonder: what about FC?
Does it suffer from the same problems?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer

