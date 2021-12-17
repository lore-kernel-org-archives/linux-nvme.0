Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71F80C43219
	for <linux-nvme@archiver.kernel.org>; Fri, 17 Dec 2021 20:44:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Content-Type:References:In-Reply-To:Date:To:From:Subject:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5VX3yVftbnIS8m0MuNGjUitSRf6sgY9+uxIdvEI9RjA=; b=uTd8SdV/Kf672QhoD9KWiLDf7z
	MTNOzPIMWnIPkWxm6g/WwW6HpHhNzPJDAPO4aLD/BWEvtzBtV6/ZBWLt9gVjnzubALArX0AWYgemb
	OmM9o7F3BGnZT67eYqgiQJ6T7sMhru/8OAsnN+q88+KsOEIWnIEJXOCkXNxtDByJjMZipYyg+4/gW
	ujPU/2DmTxrFcn/y37HBos/PLbEQRxc301uA/q/MYX4i3BjEdD1ypkIgmMRCsYpKPDTpYRS52/Sba
	8q0U0Hzv+bgklkKVr3TYMhu9a4qkeNRPHlFa/QavstMl1TYTFd2GzUwNf0xPqy+mcP+tg2QlgttCu
	Iyeqy/MQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1myK5E-00CJf6-E5; Fri, 17 Dec 2021 20:44:04 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1myK5A-00CJe6-Vh
 for linux-nvme@lists.infradead.org; Fri, 17 Dec 2021 20:44:02 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 430F61F394;
 Fri, 17 Dec 2021 20:43:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1639773836; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5VX3yVftbnIS8m0MuNGjUitSRf6sgY9+uxIdvEI9RjA=;
 b=f8F1hkEeqRBUq4RAbfifhGD/pmY8NRwvAbXBEWPgLNCK9FIcyFsfr+ZMwsV+4tmAEPxVdI
 A6gh9QCtDcMJY+VM/wDJOowvlWNK9XiYbBOCjrHtuTb5ZEFKGrMa6bTM5RFrGk0+XSWfm5
 jTmnC0Gvayjuttg/9s3/Scq1qMNH/Xw=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 11FFF132D4;
 Fri, 17 Dec 2021 20:43:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id LgaVAYz2vGFiMAAAMHmgww
 (envelope-from <mwilck@suse.com>); Fri, 17 Dec 2021 20:43:56 +0000
Message-ID: <b7bf62931bd6d45128595646a7eb637a89d216aa.camel@suse.com>
Subject: Re: [PATCH] nvme-cli: nvmf-connect@.service: Remove matching from
 default syntax
From: Martin Wilck <mwilck@suse.com>
To: James Smart <jsmart2021@gmail.com>, linux-nvme@lists.infradead.org
Date: Fri, 17 Dec 2021 21:43:55 +0100
In-Reply-To: <20211217193232.29034-1-jsmart2021@gmail.com>
References: <20211217193232.29034-1-jsmart2021@gmail.com>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.42.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211217_124401_214998_67058F93 
X-CRM114-Status: GOOD (  22.65  )
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

On Fri, 2021-12-17 at 11:32 -0800, James Smart wrote:
> commit 53aab69a0add added the "--matching" argument to the systemd
> connect script that issues connect-all to a discovery controller.
> When
> this argument is used, only discovery log entries whose target port
> traddr's match the traddr of the discovery controller will be
> connected
> to.  This eliminates the ability to do referrals by the discovery
> controller.
> 
> Revert the commit so that the "--matching" argument is not default
> behavior.

Hm, I guess you have to do revert this if it breaks referrals.

The intention of my patch was not to suppress referrals. Unless I'm
mistaken, a referral is a log page entry that lists another discovery
controller, on which then another discovery is carried out. The "--
matching" parameter was intended to ignore log page entries listing
ordinary (non-discovery) subsystems on if their traddr didn't match the
discovery controller's traddr.

I still think connecting to those entries is wrong more often than not.
In the environment I was testing in back then, IIRC there were 4
discovery controllers, each listing every subsystem on every
controller. The host would try to connect to every subsystem 4 times,
resulting in error messages 3 out of 4 times. With --matching, these
errors could be avoided.

I believe the correct solution would be to fix the way referrals are
handled with --matching. If a discovery subsystem D1 refers to another
discovery subsystem D2, then on D2 those entries that match the traddr
of D2 should be considered "matching", and so on with additional
referrals. Obviously, "--matching" would need to be ignored for the
referral entries themselves.

But as long as we haven't fixed this logic, I'm fine with your patch.

Martin

> 
> Signed-off-by: James Smart <jsmart2021@gmail.com>
> CC: Martin Wilck <mwilck@suse.com>
> ---
>  nvmf-autoconnect/systemd/nvmf-connect@.service | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/nvmf-autoconnect/systemd/nvmf-connect@.service b/nvmf-
> autoconnect/systemd/nvmf-connect@.service
> index 5fbf081..c60f146 100644
> --- a/nvmf-autoconnect/systemd/nvmf-connect@.service
> +++ b/nvmf-autoconnect/systemd/nvmf-connect@.service
> @@ -11,4 +11,4 @@ Requires=nvmf-connect.target
>  [Service]
>  Type=simple
>  Environment="CONNECT_ARGS=%i"
> -ExecStart=/bin/sh -c "nvme connect-all --matching --quiet `/bin/echo
> -e '${CONNECT_ARGS}'`"
> +ExecStart=/bin/sh -c "nvme connect-all --quiet `/bin/echo -e
> '${CONNECT_ARGS}'`"


