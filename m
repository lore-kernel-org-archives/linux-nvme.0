Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50D70C77B75
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Apr 2023 10:40:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cxDzcBuhqI7iHa+F9lsfvNzmTsbroU+seCpqi5oX++Q=; b=fUPhPn2SXZ1arlMOVo58SouGxf
	f0vnnhFRrKjz1yxB2NJLN0F5xjyK5TiU6UIZON7578zurC5N9wgtZa76wOaaP76xdh4i14hUs6NIf
	gMOxiEFnMDnLKj9QTPtXNO4L8pnYPSmDUTHY2qpdzt7buKBwXfbOoQ7Eh4trUZ+ArqzrhnwNmKc9x
	V66VDI/HtjMW3twvwrJio9QZWM/S41qXGZmVSdVE+/c7tIC9VCLCwZej0MYxBQIUU9nJ/2YAvVlGi
	GQ1ZQ5qOeDq5/bltGIbV74FGHO8KyD16zKdtpGKMyC64O+JOdBWA4lC6PvG1/uGwbq8eHR/ldoSPm
	j1m8icFg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1poikh-001m5e-26;
	Tue, 18 Apr 2023 10:39:59 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1poikf-001m3P-0L
	for linux-nvme@lists.infradead.org;
	Tue, 18 Apr 2023 10:39:58 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C88171FE05;
	Tue, 18 Apr 2023 10:39:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1681814394; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cxDzcBuhqI7iHa+F9lsfvNzmTsbroU+seCpqi5oX++Q=;
	b=dtNmxjHbquvqoVpLAenXAxNWuzUXIBbuCV58CfubCUd3D9c/cZZDzKEzXFysQcfMv+U5DE
	w/u4MKiW3u/gGirehteO8BHE/3+xYSgk6e8yhAUXIlrMGqlo+krxUpcwJvYhnllvqWY2eG
	n6HtOhIPAza8QDeRmvJRi+2RoTNqmzY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1681814394;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cxDzcBuhqI7iHa+F9lsfvNzmTsbroU+seCpqi5oX++Q=;
	b=AWI/vAklVGsN4GrtbWMSG29u6i/tqR+Lcd9p8Y2UjgL4DQI6JtkpEEnMTzZoirCjPKSbTD
	qlfiwvNFBljSy6Cg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A7FA6139CC;
	Tue, 18 Apr 2023 10:39:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id A9ipJ3pzPmQXUgAAMHmgww
	(envelope-from <hare@suse.de>); Tue, 18 Apr 2023 10:39:54 +0000
Message-ID: <b313144b-f510-f3d5-6066-6123c27039ed@suse.de>
Date: Tue, 18 Apr 2023 12:39:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 07/18] net/tls: sanitize MSG_EOR handling
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
To: Sagi Grimberg <sagi@grimberg.me>, Jakub Kicinski <kuba@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 linux-nvme@lists.infradead.org, Chuck Lever <chuck.lever@oracle.com>,
 kernel-tls-handshake@lists.linux.dev
References: <20230417130302.86274-1-hare@suse.de>
 <20230417130302.86274-8-hare@suse.de>
 <20af9713-8d64-77de-dfbe-e9e732776d3c@grimberg.me>
 <20230417131048.66b6b3a0@kernel.org>
 <beb7b0e8-2cb5-0c0e-63f9-6a13b9dfb787@grimberg.me>
 <db39fd2d-6da2-852e-70aa-7499fedf8b48@suse.de>
In-Reply-To: <db39fd2d-6da2-852e-70aa-7499fedf8b48@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230418_033957_307565_36770BFD 
X-CRM114-Status: GOOD (  19.67  )
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

On 4/18/23 12:24, Hannes Reinecke wrote:
> On 4/18/23 12:07, Sagi Grimberg wrote:
>>
>>>>> The TLS stack is using MSG_EOR internally, so the flag cannot be
>>>>> set for sendmsg()/sendpage(). But to avoid having the caller to
>>>>> check whether TLS is active modify the code to clear the MSG_EOR
>>>>> flag. And blank out MSG_MORE / MSG_SENDPAGE_NOTLAST, too, as they
>>>>> conflict with MSG_EOR anyway.
>>>>
>>>> This looks like a temporary workaround to me.
>>>>
>>>> The networking folks really need to be CC'd on this (same for patch 6).
>>>
>>> Thanks, when I said "we can support EOR" I obviously meant support
>>> not ignore it :(  No ack.
>>
>> Obviously neither Hannes or I have sufficient tls knowledge to properly
>> support it... It needs to be done by someone who knows the
>> implementation.
>>
>> Is this a large scope to add support for it? Because if it is, I'd
>> simply change nvme to clear MSG_EOR when tls is used (despite my
>> preference to not do special things for tls).
> 
> There's a rather simple patch for tls_sw. It already paces the data 
> internally by an 'eor' variable, which is currently set to !MSG_MORE.
> So evaluating MSG_EOR here is really trivial, and doesn't seem to cause 
> any issues.
> 
> Or, at least, none which would show up with NVMe-over-TLS :-)
> 
Suggestion is to change it like this (sendpage follows suit):

diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index 827292e29f99..7b28b11ff611 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -953,9 +953,12 @@ int tls_sw_sendmsg(struct sock *sk, struct msghdr 
*msg, size_t size)
         int pending;

         if (msg->msg_flags & ~(MSG_MORE | MSG_DONTWAIT | MSG_NOSIGNAL |
-                              MSG_CMSG_COMPAT))
+                              MSG_EOR | MSG_CMSG_COMPAT))
                 return -EOPNOTSUPP;

+       if (MSG_EOR)
+               eor = true;
+
         ret = mutex_lock_interruptible(&tls_ctx->tx_lock);
         if (ret)
                 return ret;

Cheers,

Hannes


