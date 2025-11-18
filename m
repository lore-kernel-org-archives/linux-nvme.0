Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6E71CEBF61
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Nov 2025 02:07:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=S97KCJ0/M+iebNYM5SPjKQEoYZVp3EkSmik6GozuJgM=; b=r5zxn8mFcmUIMOfydKOkH+doRM
	n816iw8iiUROOz1o12bk8R3LHEEA2wgtQ3VQhSrw+SEQ9a+R1mKUo+VRmc47KhwomvX7sHU1PguF1
	5wqQUtRl3gV8zmtHOuBX1D8Fa7qWhsxizcOnTUBtPcCUfXhGfCJMokdQu8J7jnI04+S2UfDK24CMy
	JerBGSbKXJivUliX0UHmkp9Erk4LREG/c+fy6inDlvhajP6ejorJXByPgasDih/qTb5XG5IxPRbPs
	VrPadZg8H7ca3qlvdTL0BBSr3iklcVkjf53b9KjvPuqpGGkgteZrdj2erl2bAdF8fOR0fWnEfR94M
	6Eh4pXNQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vLB8A-0000000HCMo-1KDp;
	Tue, 18 Nov 2025 02:07:42 +0000
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vLB86-0000000HCM2-4AcX
	for linux-nvme@lists.infradead.org;
	Tue, 18 Nov 2025 02:07:40 +0000
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-b7291af7190so715624766b.3
        for <linux-nvme@lists.infradead.org>; Mon, 17 Nov 2025 18:07:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1763431657; x=1764036457; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=S97KCJ0/M+iebNYM5SPjKQEoYZVp3EkSmik6GozuJgM=;
        b=fTQUcG1DYpyn1GGjwbitxB/YVkGbP16knYA2XqMcWLBXuNL9ZVYPtlwS5qO04Vaxsd
         aGiCeJpdLpGxgqa1sonN1QQTLKRvBBNRHoop2d+U6oxy45Uwg3TDfbWuKcO3y72MRBT5
         vnRJeIF2vUVVGfccqB7mssvq4+zHGaqmEtnKTJ1NrK5G5WNIDLK4weIvc028nJuw+7wm
         PZLDc2CLZ1omAR1y0RDz+VWiu54A7rg18419GeBD1JZo/0tWjnRtOEXLEYVCLJlHSYhc
         KHhgozcCB6RPVz3GtYzZDwdl23dozsl9sMn/JTKib4ES2wbbWAqHXSEwMfCVmocxHlKK
         aKKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763431657; x=1764036457;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S97KCJ0/M+iebNYM5SPjKQEoYZVp3EkSmik6GozuJgM=;
        b=ZpQ2ojNBjzM89k3OaKhc0UQqoh/MAxUz8bBagXs2u9Gd9eOujstfgb3WxyuoHFKzrG
         pmuOMZ3F11upv4jhpS2kV1qkxv3zxwO68sS1VRdi/+1ZcU6CyXCAsM/+KUbT18kCKiqc
         eehuFEWK4eyE5bYd8cRFwBjxr0TWmHCEWbzet8Zp1U+HFlg1/rVPmBNM2+BlRiW1SPq5
         9pUgKmTSXzmthVMPYnDThg0LpezIjxcNrZvU0l9Dxvx5e6XLmJANrytuMT8Qf0C0+vW8
         CYO9pnzKSpaaoVJr+b8W6vfyMbILEc0kg/gzhx9qOYjW3vnLyi9AGLIG8j9GBd3Q34eV
         Q74Q==
X-Forwarded-Encrypted: i=1; AJvYcCVCKeFk1btiVK5atw7cQTheZQkho+swM8hzgbL3esFSz3VxAi7/dWPiPsTON8QxmcgN9NBlqnPHOEYg@lists.infradead.org
X-Gm-Message-State: AOJu0YymxHzOtrz0CzC8tcz0zpLflexW05+2KMxRnOdkXMzhM9RukA7h
	FTnwN2ukt2P9yqm6IB43tx5E4CPJ2UGDT3IseQoNI8JOX5XNvJJZWu+I9c3DlVp4k+OuDHqZKho
	UajSF
X-Gm-Gg: ASbGncsnc8LCBJGo/kwb0gVQzO+Q5SGgH//jhk4OdaTo6bvIF6bXUC0h7W8sd7OmGNq
	56ByfnnHYS8rpgYD5OqlTlHgm9yYBF+vePmzz+QXFsiU6VZ0EKBqvVuhBCOJiU9sZf+W19HVlGk
	Wl4qZaNu+2rvMLqd6U5SIi6C9weL7MiRnyyPUgqgXt8BRl4lAhpn0WqnMVu+xnJnQJ6FkWSTDWE
	QQf6SGXu+Pd4oJR0DbfJH4VKF6nVg6vqur8u3pP+L7/tpKKz7muo5+uewRrImMq+UbFS5YgePt6
	yzBPFQNnaHpYMc0OiniAjlTTTpIqLTQKGjF+Z5z4d1voaOJcTDdnYk1ixh5GKOC8343pLglVar0
	ZMuh2EW3hfX1ww/ydzPtVPyfm8FQyjo2SdIgznbAvilBCo4w7m38G3LbV1rP8PhI1vbqaWk43ky
	Ta+sHcuxK8+mBAA4kM+1ABY1tED9vC3A4=
X-Google-Smtp-Source: AGHT+IFbl3JzHP+VT8lA2rcee7YupyauKZyKg+dpdXz8GrX8My5LD9qHQc9USZ3iiBkLaLHMiT9+uw==
X-Received: by 2002:a17:907:6d29:b0:b73:8b7f:8c48 with SMTP id a640c23a62f3a-b738b7f8f60mr843574666b.37.1763431656972;
        Mon, 17 Nov 2025 18:07:36 -0800 (PST)
Received: from medusa.lab.kspace.sh ([208.88.152.253])
        by smtp.googlemail.com with UTF8SMTPSA id a640c23a62f3a-b734fa80cb6sm1224468466b.7.2025.11.17.18.07.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Nov 2025 18:07:34 -0800 (PST)
Date: Mon, 17 Nov 2025 18:07:31 -0800
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Hillf Danton <hdanton@sina.com>
Cc: Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>,
	Waiman Long <llong@redhat.com>, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] nvme: Convert tag_list mutex to rwsemaphore to
 avoid deadlock
Message-ID: <20251118020731.GB2197103-mkhalfella@purestorage.com>
References: <20251117202414.4071380-1-mkhalfella@purestorage.com>
 <20251118013442.9414-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251118013442.9414-1-hdanton@sina.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251117_180739_101236_E86D82E0 
X-CRM114-Status: GOOD (  16.96  )
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

On Tue 2025-11-18 09:34:41 +0800, Hillf Danton wrote:
> On Mon, 17 Nov 2025 12:23:53 -0800 Mohamed Khalfella wrote:
> >  static void blk_mq_del_queue_tag_set(struct request_queue *q)
> >  {
> >  	struct blk_mq_tag_set *set = q->tag_set;
> > +	struct request_queue *firstq;
> > +	unsigned int memflags;
> >  
> > -	mutex_lock(&set->tag_list_lock);
> > +	down_write(&set->tag_list_rwsem);
> >  	list_del(&q->tag_set_list);
> > -	if (list_is_singular(&set->tag_list)) {
> > -		/* just transitioned to unshared */
> > -		set->flags &= ~BLK_MQ_F_TAG_QUEUE_SHARED;
> > -		/* update existing queue */
> > -		blk_mq_update_tag_set_shared(set, false);
> > +	if (!list_is_singular(&set->tag_list)) {
> > +		up_write(&set->tag_list_rwsem);
> > +		goto out;
> >  	}
> > -	mutex_unlock(&set->tag_list_lock);
> > +
> > +	/*
> > +	 * Transitioning the remaining firstq to unshared.
> > +	 * Also, downgrade the semaphore to avoid deadlock
> > +	 * with blk_mq_quiesce_tagset() while waiting for
> > +	 * firstq to be frozen.
> > +	 */
> > +	set->flags &= ~BLK_MQ_F_TAG_QUEUE_SHARED;
> > +	downgrade_write(&set->tag_list_rwsem);
> 
> If the first lock waiter is for write, it could ruin your downgrade trick.

How is that possible? If the first waiter or the only waiter is for
write then they should not take the semaphore because it has not been
fully released yet, right?


