Return-Path: <SRS0=5/PU=LF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47DD0C48BD1
	for <linux-nvme@archiver.kernel.org>; Fri, 11 Jun 2021 09:18:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D74460FEB
	for <linux-nvme@archiver.kernel.org>; Fri, 11 Jun 2021 09:18:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D74460FEB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=camciMDssFvvnJtgIk8p9Of53z/5xDvCa/LcJqeoRMY=; b=f8+6kI8mECUHh1
	kZXjTCIwx53YIILq+gn0PuJfyqTyDUAFKN8PGUkIr7vbLIgcFRP0ztKRu0/9wN20YkXii5KI3TdIA
	HIIqYSqTUyJsoruCCJGsZlYnlAPIBH5EVkzJTBej0fW4ZII2MjCoDLqU3SDACLUXHEYd5KhkS+ODO
	84rAKfF4RBsJQU++yV/HSUxoTDf2NWb1nAyxNgCo2uOXMM1b6DeTxODbw5fWQcp73n2E2UIRG6fyj
	07yi5l2Wgmtl90+nXjtp/1Mgjspeu+1oE1M3NXGplEluHA84nWwz5uarfDSsfQO+rVVZJXK3ndcmx
	/3KkSfwNnBLud0ZSq+sw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lrdIU-004UOC-I8; Fri, 11 Jun 2021 09:17:50 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lrdIN-004UMw-Q4
 for linux-nvme@lists.infradead.org; Fri, 11 Jun 2021 09:17:45 +0000
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
 (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 6C0EE21A1E;
 Fri, 11 Jun 2021 09:17:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1623403062; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GRW5UQm25fgJp/Ko4ri8QUhErh9LSHV4HD8lqs53Tb4=;
 b=sy7B6cDCRFW2c/94jdVSvjsDPLJTKXu5Ulhfj+mHByiVVE/hAM8VIBjKgnE7cUANw7oQ44
 PNpP3CsRxOBjIZgDdkeG3tdXWXm8qaRLKOyeJjnmVNRiuumeQsPmqWVic0WtbjPoh7xsUu
 MBlGQ/wiMETDTJRsh1287B4oSGsZ8iE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1623403062;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GRW5UQm25fgJp/Ko4ri8QUhErh9LSHV4HD8lqs53Tb4=;
 b=5P2u/H1mWUtrdnHzOAMr4kFDVKuI2zZaxpI67lCX09hRb5LMfbNS68T6tf313vcXDEXY6e
 bFSGXOrpzqtex5Cg==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
 by imap.suse.de (Postfix) with ESMTP id 539A2118DD;
 Fri, 11 Jun 2021 09:17:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1623403062; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GRW5UQm25fgJp/Ko4ri8QUhErh9LSHV4HD8lqs53Tb4=;
 b=sy7B6cDCRFW2c/94jdVSvjsDPLJTKXu5Ulhfj+mHByiVVE/hAM8VIBjKgnE7cUANw7oQ44
 PNpP3CsRxOBjIZgDdkeG3tdXWXm8qaRLKOyeJjnmVNRiuumeQsPmqWVic0WtbjPoh7xsUu
 MBlGQ/wiMETDTJRsh1287B4oSGsZ8iE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1623403062;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GRW5UQm25fgJp/Ko4ri8QUhErh9LSHV4HD8lqs53Tb4=;
 b=5P2u/H1mWUtrdnHzOAMr4kFDVKuI2zZaxpI67lCX09hRb5LMfbNS68T6tf313vcXDEXY6e
 bFSGXOrpzqtex5Cg==
Received: from director2.suse.de ([192.168.254.72]) by imap3-int with ESMTPSA
 id A3xtEzYqw2ABUAAALh3uQQ
 (envelope-from <dwagner@suse.de>); Fri, 11 Jun 2021 09:17:42 +0000
Date: Fri, 11 Jun 2021 11:17:42 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH] Revert "nvme: verify MNAN value if ANA is enabled"
Message-ID: <20210611091742.6iefvwlxjlm6oiae@beryllium.lan>
References: <20210610024539.28875-1-chaitanya.kulkarni@wdc.com>
 <BYAPR04MB49655A9B821FEE29D7A89E3986359@BYAPR04MB4965.namprd04.prod.outlook.com>
 <20210610074546.jyqjalpldii6reg6@beryllium.lan>
 <BYAPR04MB4965AE59EF50A714B12DF42886359@BYAPR04MB4965.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <BYAPR04MB4965AE59EF50A714B12DF42886359@BYAPR04MB4965.namprd04.prod.outlook.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210611_021744_037690_1BD79351 
X-CRM114-Status: GOOD (  13.25  )
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

On Thu, Jun 10, 2021 at 09:01:14PM +0000, Chaitanya Kulkarni wrote:
> commit 1368a1a5e7566d726bf74234d05895c3f0d54690
> Author: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
> Date:   Wed Jun 9 20:07:00 2021 -0700
> 
>     nvme: fix the comparison in the mnan check
>    
>     The existing check for the valid mnan value will result in the error
>     when ctrl->max_namespaces are set to the 1024 from NVMeOF target since
>     !1024 == 0 so it will lead to next comparison 1024 > is->nn which will
>     be always true untill target has 1024 namespaces.

The commit message doesn't make sense to me. NSID is not limited to
1024.

From the discussion in the other mail, I though the argument is, if
there are no namespaces on the target the MNAN is allowed to be
zero. The original check assumed there are always namespaces. The
proposed fix drops the first half of the specs statement:

  ... then this field shall be set to a non-zero value that is less than
  or equal to the NN value.


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
