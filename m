Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 409F2C35FFA
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Mar 2025 15:57:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1KzekhT3fuNkkJJp0SniK3EZo8iFnDvuMLiZ4d+njnc=; b=rJFBBCQrchWymE59nu0cjlJhOy
	VS7fJBpAv8FWAR0yyC2Dj5+C/WW69SZrSr5W4Kuy9iwTafhCnfdM42iXmzMvrmpIB5J/Lb4sve4pL
	zTQnpsiuAxkse25iJxvssvLFddV70MQ6TQm2AA+PayeIwIXwP+ndZgsRlIU5wfc/dvTg3R3MqdyMA
	BMdbjDaslR8XUfb0x9olkNlZY3gEr1A2GAWIRXXvVG8t0qHinEl0wPFi+FHNhom52VSbu08c3ks1b
	w0RItpm6JNItYssmqj+iRTVt/+MI0/nTNBv8N60hqPlUcVoo6ZrVEklxtZeXbCGckWCfNnJ44QwKz
	cL+Utprw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tuvni-00000009TFe-3cEb;
	Wed, 19 Mar 2025 15:57:50 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tuvng-00000009TEv-2kh1
	for linux-nvme@lists.infradead.org;
	Wed, 19 Mar 2025 15:57:49 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id DA7B7A4919C;
	Wed, 19 Mar 2025 15:52:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BE69C4CEE4;
	Wed, 19 Mar 2025 15:57:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742399867;
	bh=gCYFLRg6WoCBiXW/ebcMi7Yod4kWcH/GShwnOhU0PMg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=frzTHNsruxXzheZ+V6399nrt6CpJGLCjaoRfyGO0GAFoIuHjQnJ/xYD3YNrdeGxGt
	 LesZ4MfbvcCwTv90nxsoXCzlmLh1VmtGYAUb7zzVzOk8IJyMGsnAzv/8E8MzvlUmez
	 oSod1GJoWNEKnibXf1x3C4kceTb55+UScKLzV1rXS3Ku9+cs68rztCWaOnPNg7O4IT
	 LpZTG0r+B9lO6Sj2CUtMMcQiD4H5BSmbwGgAVaapMfH072DXJrot9z4NxvrJRLb8e5
	 ECmPbVqd3IuwuGm3s6bKmd3CRWkkmtUtsU3yFcGod2Rt6rcW8Ee+UQJkmtjHgvxYBx
	 FE5NK7sd2tp9A==
Date: Wed, 19 Mar 2025 09:57:44 -0600
From: Keith Busch <kbusch@kernel.org>
To: David Wang <00107082@163.com>
Cc: axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: nvme interrupt counters got reset after suspend/resume
Message-ID: <Z9rpeIsNlf6SBWi6@kbusch-mbp>
References: <20250319153910.18684-1-00107082@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250319153910.18684-1-00107082@163.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250319_085748_758589_CD6A9A6D 
X-CRM114-Status: GOOD (  11.77  )
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

On Wed, Mar 19, 2025 at 11:39:10PM +0800, David Wang wrote:
> 
> This does not happend to counters for other interrupts on my system.
> Not sure whether this is designed explicitly this way, or happended to be this way to make suspend/resume work,
> or there is some bug behind this.

The nvme driver completely brings down the interrupts on suspend and
creates new ones on resume. They might have the same numbers and labels
on the other side of the resume, but they're not from the same original
allocation that tracks these stats. Hope that helps.

