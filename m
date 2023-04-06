Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4503C7618D
	for <linux-nvme@archiver.kernel.org>; Thu,  6 Apr 2023 06:17:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PI0V3VGiW12lvl/2LJ14W4Dt1wz1QsN+t9i8GNG9b84=; b=kxhZ210iJ/dmAd639+sy1Kp4q7
	7iTADMjnjNEzL4id08YzZbjfFlfaeBShtNNIEQpumgL8tb3UPZyVNPWAQTqBCBOVrj/lxB0imlc8P
	klvMNXEzN/74CcC8jodw8s0Ep9k7o52VWjyzya1KmipJcX175WmdK2rcAH583pwpnCztzIGJRwDQc
	EPCwsYPz/AEJa2goOjZRpTzVZgz/YLJcVFIJwVRf8EmBaoO7Vzn4jbMS+9XJ1RMox07mik1ws6XFJ
	c2MOnVODbQh3VYG6SGMaN0gGiVYJ4eNCUU4wXaYYndnF7vigjW3M7P75Aee5oZGNnXDj7eE4rCRpv
	MCvsjOGw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pkIwI-006SRF-38;
	Thu, 06 Apr 2023 06:17:42 +0000
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pkIwG-006SPg-1g
	for linux-nvme@lists.infradead.org;
	Thu, 06 Apr 2023 06:17:41 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 684711FF43;
	Thu,  6 Apr 2023 06:17:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1680761856; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PI0V3VGiW12lvl/2LJ14W4Dt1wz1QsN+t9i8GNG9b84=;
	b=mHn2Y6jdhOl3r2V5EnJqaugIdklM87zj7QmmOudwP958oVxhuAQWmnHo0JdO+Ww18McXfi
	O9chc8UV+RtuPPQKmnr6+7SJuER0hwG/A0fRqbb9bV9b9Vf9v92re/0UAn+woZCZM8HMPP
	oQb5Hyd8Q/DxehtsMyH8wEdHI8Xv83E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1680761856;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PI0V3VGiW12lvl/2LJ14W4Dt1wz1QsN+t9i8GNG9b84=;
	b=n8s/HeoJQZk2Y5KuICNyOIqYozsUridAb4wV1ecEvz8ssLyNR9QDFNtOFjNVCLEIINHKQS
	wWN5PZ/GJ8/HmwCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 581D8133E5;
	Thu,  6 Apr 2023 06:17:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id QmUKFQBkLmQSIwAAMHmgww
	(envelope-from <dwagner@suse.de>); Thu, 06 Apr 2023 06:17:36 +0000
Date: Thu, 6 Apr 2023 08:17:35 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, 
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>, 
	Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>, 
	James Smart <jsmart2021@gmail.com>
Subject: Re: [PATCH blktests v5 4/4] nvme/048: test queue count changes on
 reconnect
Message-ID: <lgqrsky6qbdiyhnzunc453mpbgxvr4fi5fumpi6xrhvd3lfgvf@vakvam7bkerx>
References: <20230405154630.16298-1-dwagner@suse.de>
 <20230405154630.16298-5-dwagner@suse.de>
 <b469de5e-0005-b123-8473-6b95661e78d7@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b469de5e-0005-b123-8473-6b95661e78d7@nvidia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230405_231740_701296_3B061E17 
X-CRM114-Status: GOOD (  15.66  )
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

On Wed, Apr 05, 2023 at 06:57:49PM +0000, Chaitanya Kulkarni wrote:
> 
> > +	if ! _detect_nvmet_subsys_attr "attr_qid_max"; then
> > +		SKIP_REASONS+=("missing attr_qid_max feature")
> > +		return 1
> > +	fi
> > +
> > +	truncate -s 512M "${file_path}"
> > +
> > +	_create_nvmet_subsystem "${subsys_name}" "${file_path}" \
> > +		"b92842df-a394-44b1-84a4-92ae7d112861"
> 
> by checking following after create subsystem in testcase itself
> we avoid whole process of creating and deleting subsystem and
> additional function in the rc file, because we are already creating
> subsystem as a part of the testcase :-
> 
> local attr="${NVMET_CFS}/subsystems/${subsys_name}/attr_qid_max"
> 
> #above tow vars go top of this function
> 
> if [ -f "${attr}" ];then
>      SKIP_REASONS+=("missing attr_qid_max feature")
>      #do appropriate error handling and jump to unwind code
> fi
> 
> again please ignore this comment if decision has been made to
> keep it this way for some reason...

Again, no decision here. I think I overengineered this part slightly. Indeed if
we are goint to setup a controller anyway we should try to avoid double work.
This should also speed up the test slightly.

Talking about execution time, I was thinking on reducing the timeout value
to reduce the overall runtime.

