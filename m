Return-Path: <SRS0=7/ZJ=QG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25939C433EF
	for <linux-nvme@archiver.kernel.org>; Fri, 19 Nov 2021 11:29:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5BE161A58
	for <linux-nvme@archiver.kernel.org>; Fri, 19 Nov 2021 11:29:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D5BE161A58
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fyLtb5CiUrSVK0oxX6Zrr43cslzU9bP/48lNcNiy/rs=; b=3/6bJ3GJHsWbY7WKVO3h8ehskT
	xysV5pRXz31MCquirTu6e6rw8SzgraMLz7GIjSYQW7uADCOCMJXDexbryfkKxUy57hL9cyTAJytmB
	FhXCoKQxgUjuXipKc6nySYI0VzhPkHWHVeNJaxRmp1DFHbtdrJZ+df41/jGpcfviaTkz47u1bXpY3
	SlxY6fQLkmEea/gRsKGyjFctnqrQIFp0T+BPoq3rpi38m6NHCCZyJG1CBtE2P88aGX2ZwbJfP3UY2
	ylmk6SieN+k42+CKmyEdkHCqsage6GOX/N6rAaz0QcLy3Xe5R2R1fsiHQR7/UVq4cYBM41azWuIsk
	l2nzgKlw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mo25W-00AG2K-Oa; Fri, 19 Nov 2021 11:29:50 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mo25T-00AG1X-Qe
 for linux-nvme@lists.infradead.org; Fri, 19 Nov 2021 11:29:49 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 601951FD39;
 Fri, 19 Nov 2021 11:29:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1637321384; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fyLtb5CiUrSVK0oxX6Zrr43cslzU9bP/48lNcNiy/rs=;
 b=0cfBPPXZ/9Hbs4DGI5QG/XuW6DzpWtYcCPxPW7/z7n5lVH8tFNgx3G2HTEKLEcILJOmwOF
 JjJMxNK9FlYaKF801ev0mYj0lctZKP63Ul5dlDbqykjZ+ixPQWfOWR7m1ZQHFXCHHl5AgX
 0DIIliDX0nj/fzInTvju/RXOtRzpk54=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1637321384;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fyLtb5CiUrSVK0oxX6Zrr43cslzU9bP/48lNcNiy/rs=;
 b=DStn2YEb9HlTGolUfQlmheV5Oy4+9BhHCzYB7uzwpvOBixczkH/APt5slsHvqP5Hr0TFrn
 YOANuQVhV1nOWABQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2237F13B1E;
 Fri, 19 Nov 2021 11:29:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id p+DEBqiKl2HrLQAAMHmgww
 (envelope-from <hare@suse.de>); Fri, 19 Nov 2021 11:29:44 +0000
Subject: Re: [PATCH 5/6] nvmeof-tcp/005: test bi-directional authentication
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <keith.busch@wdc.com>,
 Omar Sandoval <osandov@fb.com>, linux-nvme@lists.infradead.org
References: <20211112144510.98523-1-hare@suse.de>
 <20211112144510.98523-6-hare@suse.de>
 <c34f1bbc-c54e-9e9e-86ed-421ea602efe8@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <5d919dbd-be95-3465-1b51-a3be84ffa194@suse.de>
Date: Fri, 19 Nov 2021 12:29:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <c34f1bbc-c54e-9e9e-86ed-421ea602efe8@grimberg.me>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211119_032948_058733_BA77953C 
X-CRM114-Status: GOOD (  20.83  )
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
> 
D'oh. Fix is:

diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
index 4dafa04aee8c..68f195dd245a 100644
--- a/drivers/nvme/host/auth.c
+++ b/drivers/nvme/host/auth.c
@@ -1351,7 +1351,7 @@ static void __nvme_auth_work(struct work_struct *work)
        }

        ret = nvme_auth_process_dhchap_success1(ctrl, chap);
-       if (ret < 0) {
+       if (ret) {
                /* Controller authentication failed */
                goto fail2;
        }

I'll fold it into the next version.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer

