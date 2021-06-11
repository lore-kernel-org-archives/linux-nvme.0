Return-Path: <SRS0=5/PU=LF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63979C48BD1
	for <linux-nvme@archiver.kernel.org>; Fri, 11 Jun 2021 09:08:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E12B613C8
	for <linux-nvme@archiver.kernel.org>; Fri, 11 Jun 2021 09:08:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E12B613C8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=UUtSLs0vrTY8g2IOs/jM+0xovQUAOzuKBwe7YVj0a9c=; b=1orEFqstYJQGrs
	7S4Vhh/Z2mbvAMp5GQw05CGeOCcyAZDLLALoaYaOOQRfaTLrX70lhG9iLbA1fiVBLmM8ZXAym35vW
	1JN8/h+P7z5StKvgV1p/gpYl3VN6GUuVVkSKQRnxL+oW2w/p6iw7XgfgrOtHw8hmGNYio3+xP3EKv
	+HlTp7U4PO/vlGwrtmLHaUXwZ4XJLEHrA5Qb9mxB+ZNiS5yPq3qnOQuzEESUJ8wD7jeltDRmarUbg
	2aZ3DvQNMlqFTgiHKK/shat7fPmHRUBrAy3HlJvE2BciMWbhRevntYaNmyea9Qr0iPRuhp3KZjaU7
	qhwmv/K2Q2+KSVU7M/QA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lrd9O-004SKI-7L; Fri, 11 Jun 2021 09:08:26 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lrd9L-004SIz-EF
 for linux-nvme@lists.infradead.org; Fri, 11 Jun 2021 09:08:24 +0000
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
 (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id BBEC4219A2;
 Fri, 11 Jun 2021 09:08:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1623402499; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Q4EzD7uuV+UUvCrM2JaWySJG1Fj45d5itMWNoVE1TAI=;
 b=smr8XhFnpnjpsoCDnIrsCJeIIM7pUfJxDD1Jbg7/d2mOj8m1nA7ArvSaYNpo36GxU1JDGC
 4YMHWWF7Pm5QYKTWAN7BLIuUX/hx5CV0JgP9qNBKj03Aa6QpXCmprKvGXyw5QKJlElu/I3
 N5XBiTcKkVcigPYYDti0cse4aXo/0qI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1623402499;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Q4EzD7uuV+UUvCrM2JaWySJG1Fj45d5itMWNoVE1TAI=;
 b=YnfJmPHMrSDCxSmziVKrrAZioP2mCO/5ZTN3L9F2v3ZB5sjcoBnheBQe1fEVITCsy4GbQ8
 S1uqU6LETm3L8DCQ==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
 by imap.suse.de (Postfix) with ESMTP id A0DA0118DD;
 Fri, 11 Jun 2021 09:08:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1623402499; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Q4EzD7uuV+UUvCrM2JaWySJG1Fj45d5itMWNoVE1TAI=;
 b=smr8XhFnpnjpsoCDnIrsCJeIIM7pUfJxDD1Jbg7/d2mOj8m1nA7ArvSaYNpo36GxU1JDGC
 4YMHWWF7Pm5QYKTWAN7BLIuUX/hx5CV0JgP9qNBKj03Aa6QpXCmprKvGXyw5QKJlElu/I3
 N5XBiTcKkVcigPYYDti0cse4aXo/0qI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1623402499;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Q4EzD7uuV+UUvCrM2JaWySJG1Fj45d5itMWNoVE1TAI=;
 b=YnfJmPHMrSDCxSmziVKrrAZioP2mCO/5ZTN3L9F2v3ZB5sjcoBnheBQe1fEVITCsy4GbQ8
 S1uqU6LETm3L8DCQ==
Received: from director2.suse.de ([192.168.254.72]) by imap3-int with ESMTPSA
 id I+WjJgMow2DiSgAALh3uQQ
 (envelope-from <dwagner@suse.de>); Fri, 11 Jun 2021 09:08:19 +0000
Date: Fri, 11 Jun 2021 11:08:19 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH] Revert "nvme: verify MNAN value if ANA is enabled"
Message-ID: <20210611090819.d2ths7e4swfuj2s6@beryllium.lan>
References: <20210610024539.28875-1-chaitanya.kulkarni@wdc.com>
 <BYAPR04MB49655A9B821FEE29D7A89E3986359@BYAPR04MB4965.namprd04.prod.outlook.com>
 <20210610074546.jyqjalpldii6reg6@beryllium.lan>
 <BYAPR04MB4965781915C1D4AFF2830E9586359@BYAPR04MB4965.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <BYAPR04MB4965781915C1D4AFF2830E9586359@BYAPR04MB4965.namprd04.prod.outlook.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210611_020823_665626_6317E7B7 
X-CRM114-Status: GOOD (  13.73  )
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

Hi Chaitanay,

On Thu, Jun 10, 2021 at 08:32:56PM +0000, Chaitanya Kulkarni wrote:
> Let us look into the host side issue first then we can move to target side.

Sure

> Consider a scenario where ANA enabled subsys with 0 namespaces on the target
> side. When host issues connect command to such a controller ctrl->mnan
> should be 0 and ctrl->nn should be 0 which should be valid.
> 
> With original check in the code :-
> 
> if (!ctrl->max_namespaces ||
>     ctrl->max_namespaces > le32_to_cpu(id->nn))

In the scenario you describe this is obvious wrong. I suspect we can't
decide if there are namespaces on the target side enabled or not at this
point. Maybe later in the discovery path we could check max_namespace
again. But I don't know if this is the trouble worth.

So yes I agree with your proposed change. In the end it's not important
anyway.

Thanks,
Daniel

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
