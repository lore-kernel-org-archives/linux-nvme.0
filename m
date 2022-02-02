Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A9D9C433F5
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Feb 2022 18:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ofv7V/MQVvyAB2zyifMmag7SP5keFFOIeiBWbFRtzaU=; b=EIX+n19y6+k5N1Pwjgm+90WnsZ
	GnhJOPaKn3Cia98vZRy7BZ6gZ3+uM4LD/VPJF5mW8Zl9yBofJx3MzGFmBVQq03tN6ZEqnSAki+ZjC
	ZD+ivTRGUFvVZop7vvkRvpCkrW1K6AteWGEuWyOM8xsY/vRZbpxPKU2Akzlf4yp393WVmgbJBQOJo
	qoKc4ddn4DorqLWSgKTTtanaEpVb03Igc7iRtc5tnwcd3Tq2n9RfeuPPh6FzX56MyfWHQgWUzTMZ0
	/kC6F3wAI0M3l9xf1DXjjqt0idLAJ7gE2jV63P6blhNUQcRgHJwAzF66O46ietr2XYKDFpvYEI9Bx
	k6vLz4ww==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nFKOi-00GaTa-0G; Wed, 02 Feb 2022 18:30:28 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nFKOe-00GaRw-FA
 for linux-nvme@lists.infradead.org; Wed, 02 Feb 2022 18:30:25 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id DAA3B1F37C;
 Wed,  2 Feb 2022 18:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1643826620; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ofv7V/MQVvyAB2zyifMmag7SP5keFFOIeiBWbFRtzaU=;
 b=JNMlzSCbec767vPRfVpOmFvG5C2r21R69LEV1Qn56i6rTVQ3Lwth4L9j7j0MV/VkVj8srM
 5MskiOlqBcuDF6khSSZt32NSIcnX+jKC4Mkav605vBUWT7M4YwbHu9GRqTJzO3nc5H9Gkt
 uZSpqMnA6eOZMJ7PzgqTzom0CvVqYXY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1643826620;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ofv7V/MQVvyAB2zyifMmag7SP5keFFOIeiBWbFRtzaU=;
 b=7+W85VwULlaftlUvRleNHXP3k2CPXLAWirjTWTR285341BYHOdCH9dRQqyfdO3p5IuWxO/
 o45sC6oCwTlXfOBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5419C13E25;
 Wed,  2 Feb 2022 18:30:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 2dCVBrzN+mG6awAAMHmgww
 (envelope-from <ematsumiya@suse.de>); Wed, 02 Feb 2022 18:30:20 +0000
Date: Wed, 2 Feb 2022 15:30:17 -0300
From: Enzo Matsumiya <ematsumiya@suse.de>
To: Chuck Lever III <chuck.lever@oracle.com>
Cc: "lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
 CIFS <linux-cifs@vger.kernel.org>
Subject: Re: [LSF/MM/BPF TOPIC][LSF/MM/BPF ATTEND] TLS handshake for
 in-kernel consumers
Message-ID: <20220202183017.ryv43nebh4ane42u@cyberdelia>
References: <3a066f81-a53d-4d39-5efb-bd957443e7e2@suse.de>
 <C4E94EAA-7452-4D69-9C06-E5AD5B7A1F14@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <C4E94EAA-7452-4D69-9C06-E5AD5B7A1F14@oracle.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220202_103024_684923_BABA2B9C 
X-CRM114-Status: UNSURE (   7.06  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 02/02, Chuck Lever III wrote:
>[ ... adding NFS and CIFS ... ]
>
>> Required attendees:
>>
>> Chuck Lever
>> James Bottomley
>> Sagi Grimberg
>> Keith Busch
>> Christoph Hellwig
>> David Howells
>
>Anyone from the CIFS team? Enzo? How about Dave Miller?

I'll be attending representing the CIFS side. I hope to have my
prototype more solid and public by then.


Cheers,

Enzo

