Return-Path: <SRS0=aga3=QF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65675C433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Nov 2021 09:40:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25911613B1
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Nov 2021 09:40:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 25911613B1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iV3Abq8S821b961DWgNz8ToHgYtN5I1Aa3G2PTmlcs4=; b=lNSE4bZbb+SgrDr/vS/iYYtxkx
	dhTDNVlFXfPkD7JMq3TnVaAWUCTnP2i/cv6hRDgLA40Wlv+PRvBcnQlQa7dpLMvucdje0HND9H4Gy
	D+63ShxQ4ZHwvUTKqDHX3RvB5vRiDepl0KiN+unryewszM32VitXNDqKfp6UGfbjLUzGuIrwe4D8f
	/TyIjnsnPp2P9lApbgOzz8+uW8BCj+MsCD8nLezu1r5anq0IqGhCJS82SvrgSwioltsIT38Cqyy3u
	CXkC2dhn7AxsrudSPwnXcZONiOUmSSpehbyiy1AD41FBHHF01k1+J5b6457QR1jnEPbkpmCdBG4s2
	HR1dNyHg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mndtx-007MOB-7n; Thu, 18 Nov 2021 09:40:17 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mndtu-007MNS-1S
 for linux-nvme@lists.infradead.org; Thu, 18 Nov 2021 09:40:15 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E33C21FD37;
 Thu, 18 Nov 2021 09:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1637228410; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iV3Abq8S821b961DWgNz8ToHgYtN5I1Aa3G2PTmlcs4=;
 b=odn5V0rUc6v4H6/hFo5SicXFn1/pfQBREQyxZ6TL687hOtC329l+w7XqK0SOQdWBw7XiuZ
 wAaJgaJk6kq/6kibkW7fZoiXLZ5B68aQ2QI6J8elsFz5DLbFwZDjKzv/LU0oUjTJYBTwO9
 /izzwQCIslNuJLNHLSUW1+UMhUZLFeM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1637228410;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iV3Abq8S821b961DWgNz8ToHgYtN5I1Aa3G2PTmlcs4=;
 b=6qr5in47n50XhGJBWjLktbPB6MIa0fKhLYYvNRRaHd2I/BznOQ4N+2HTwFXP08jWHTiV4y
 kYrEmueHwinlGkCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D3D8E13D07;
 Thu, 18 Nov 2021 09:40:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 4w1eM3oflmE+dwAAMHmgww
 (envelope-from <hare@suse.de>); Thu, 18 Nov 2021 09:40:10 +0000
Subject: Re: [PATCH 5/6] nvmeof-tcp/005: test bi-directional authentication
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <keith.busch@wdc.com>,
 Omar Sandoval <osandov@fb.com>, linux-nvme@lists.infradead.org
References: <20211112144510.98523-1-hare@suse.de>
 <20211112144510.98523-6-hare@suse.de>
 <c34f1bbc-c54e-9e9e-86ed-421ea602efe8@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <e1436a8e-396e-e262-c535-c0602b8455bb@suse.de>
Date: Thu, 18 Nov 2021 10:40:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <c34f1bbc-c54e-9e9e-86ed-421ea602efe8@grimberg.me>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211118_014014_279793_284CDDF5 
X-CRM114-Status: GOOD (  18.02  )
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

On 11/17/21 10:50 PM, Sagi Grimberg wrote:
> Hannes,
> 
> Should we add negative test cases for each of these tests?
> Currently for some reason I'm able to connect even though
> I provide the host a different dhchap_ctrl_key.
> 
> Controller:
> -- 
> # grep -r ''
> /sys/kernel/config/nvmet/hosts/nqn.2014-08.org.nvmexpress:uuid:b73ff014-2723-4114-aa8d-2f784ecba4f4
> 
> /sys/kernel/config/nvmet/hosts/nqn.2014-08.org.nvmexpress:uuid:b73ff014-2723-4114-aa8d-2f784ecba4f4/dhchap_dhgroup:null
> 
> /sys/kernel/config/nvmet/hosts/nqn.2014-08.org.nvmexpress:uuid:b73ff014-2723-4114-aa8d-2f784ecba4f4/dhchap_hash:hmac(sha512)
> 
> /sys/kernel/config/nvmet/hosts/nqn.2014-08.org.nvmexpress:uuid:b73ff014-2723-4114-aa8d-2f784ecba4f4/dhchap_ctrl_key:DHHC-1:03:M4ik+B5zPy9vqzH0Ef9sLWXLL7HQ1JEqx0IkhMWwNPc0tq8ZLkTQstMl1A9wkMFzzo52hJwQ0wP9GELWmUwUgFisuGw=:
> 
> /sys/kernel/config/nvmet/hosts/nqn.2014-08.org.nvmexpress:uuid:b73ff014-2723-4114-aa8d-2f784ecba4f4/dhchap_key:DHHC-1:03:ynOWXFT8AC/OlvuIkpQ1RQlDAuHz2axeP43zmws90yRhPHNP5HyDQSI3m+WCBKcUfl7gRraflcb7nHAHR5mTh9t22Js=:
> 
> -- 
> 
> Host (use same key for -S and -C):
> -- 
> # ./nvme connect -t tcp -a 192.168.123.1 -n testnqn1 -s 8009 -S
> "DHHC-1:03:ynOWXFT8AC/OlvuIkpQ1RQlDAuHz2axeP43zmws90yRhPHNP5HyDQSI3m+WCBKcUfl7gRraflcb7nHAHR5mTh9t22Js=:"
> -C
> "DHHC-1:03:ynOWXFT8AC/OlvuIkpQ1RQlDAuHz2axeP43zmws90yRhPHNP5HyDQSI3m+WCBKcUfl7gRraflcb7nHAHR5mTh9t22Js=:"
> 
> # nvme list
> Node                  SN                   Model             Namespace
> Usage                      Format           FW Rev
> --------------------- --------------------
> ---------------------------------------- ---------
> -------------------------- ---------------- --------
> /dev/nvme0n1          c7ebe13b94f6ad3885c7 Linux             1        
> 268.44  GB / 268.44  GB    512   B +  0 B   5.15.0-r
> -- 
> 
> Am I doing something wrong?

Hmm. Not that I can see.

I'll be checking what's going on here.

And yes, some negative tests won't go amiss.
I'll be adding them; or, rather, update the current ones to test with
mismatched credentials, too.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer

