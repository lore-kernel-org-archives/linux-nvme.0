Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84FD9CA6007
	for <linux-nvme@archiver.kernel.org>; Thu,  8 Oct 2026 05:39:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5zICbZB1R9qSjUQuU/dNeAk5DIiO8jYcPtpT7WWKmXU=; b=BwRCKSbxGWngjTQrz2VtNnpBXB
	xS6R9PJiFAspOC0m4hGi8q4NUtcy9CfqHFOCp0gYNNOO7oYH3IQmcyeXMdR6d/LtXcZWb6aXENE83
	rO//yYvfGiOc834vI0oAF3EncaYt6jzoqwFQM/WedCmv/YEkRqAScoq5Ic0uWkSaOl0cbdQ85QPkY
	IhriPx8WrNXlcQFQArRIqqdA7MWPkYUQSqzDPXe88Kiw7oakZue+m8XilTqoqs5VQEHS/lf79+T2x
	x5s0aLou43OCrQT15I2KKUo3uSJRbJMppF/3aclZQwC/LYG5AZHpHvWqFaWX0vhBMQZGTVxR4kvnP
	XwgUy0cg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xEgqa-00000003Z1s-25UG;
	Thu, 08 Oct 2026 05:39:16 +0000
Received: from mail-dl1-x1229.google.com ([2607:f8b0:4864:20::1229])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xEgqX-00000003Z1J-2Xb1
	for linux-nvme@lists.infradead.org;
	Thu, 08 Oct 2026 05:39:15 +0000
Received: by mail-dl1-x1229.google.com with SMTP id a92af1059eb24-15756f82e8aso1552624c88.1
        for <linux-nvme@lists.infradead.org>; Wed, 07 Oct 2026 22:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=crusoe.ai; s=google; t=1791437952; x=1792042752; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5zICbZB1R9qSjUQuU/dNeAk5DIiO8jYcPtpT7WWKmXU=;
        b=hv8J47zcSDDT85kG14ZkVkSM0spyVTA0UwAF6wBmaSpoptb58CkXh1Zn0ThVB8PFr4
         MlkjHEjOckIJ+fZXTFRisbDx8QBbcxIq/7E5aI2dgiXIBBCTJ2lBDAr24cXzWF8R9icZ
         7IeqML2LuUTvu4o/sCsU8y/YYvbkBAlUa/6yUKupOzAA9kkYUXpx+WESox7kdTgz8eZV
         VeIHjhAthISlHfLS9j7HE5eNCO8O/eiAPp0btudcetJuqroEQjSRM5cvf9JxCH8Uaz1x
         0AxxCaS2qMwaF24nnN+9yJ+ViLbFoOBm1l1OqNd5ZdBPUJCHgsCtwXssLILCfGS6go9V
         dZiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791437952; x=1792042752;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=5zICbZB1R9qSjUQuU/dNeAk5DIiO8jYcPtpT7WWKmXU=;
        b=NvXr90aDsQ2Q6vCm+/Nhikg7Eq+DT+hVsc5XA52hlOPUUbvPwSIu2+QjaBv0jOUNhF
         2HXpuzt1WS/xXrliqCyG3F+LrYNJvfhMIgX0rInR9gI4tgOvgzMxO9fJsqaIowKTGY/7
         5L86elr5xMOhxjGGwWkfDXR69mkigfMDHHVmxp/8xvfGIKF5oPzuCvW5rYLQ36mG6Aey
         5uwL6R54O+ly9QFY2L6bLZbJESxmtzTLnJwb+fir/pN/5M2LjIquQIAHwVBEdz9oQ0PT
         elSkQSngfPN/+tqilpnXqdgtC2F1lM18IXb9O+Fz5C5BdLtbD1gIKzBjksrpkWjRvKQi
         WZuQ==
X-Gm-Message-State: AFuF++nLPBQ8CN+pia3PxiIJXtYUR9inK5HNjHzWzG/t9nhItj6Bzd42
	HaA7FsU0CxcPYCB1awszNQ6nf1HU3AoHtNxtjLafd/hsSWJxFHKXMBYhZSLIYPv4Nk9n+0Ktlb7
	W5qi7abc=
X-Gm-Gg: AYBFou3f1zUoNoxYFF0O/ERcQKSWUnsYi1cU+ClIuQLX0ODBU2QAClxVG45K7OpnwkB
	fdYnPMeIdZHfThg1BVR5Lsa3roB/8GsYZSjgxRd93AHezAYNMBnlqr+of4C81fS+3dou/u61CGv
	bmDjlatHy4yQc8KqziucjrPCzpSt+bjqM1V+FqYfxoF5eAL61HyLfEZRKRjvWzLzqSr4wlOFY/T
	dK3pMJTC+DDrsTCWAxJAnixHoVHOqvByOKwS0xGORIMuwlG+36j/noeI+a02HAEqfjHgct2WE0A
	G/ToDsllVJSGjhB6ECKqUq4hvz1fo8RjP9zqkdKQHiFGhOM5tLV4y4/KaBLPY/6ZmXKvFG73/zF
	FbadSPr8SrMWtgT1P8U6GO1lwWuBfmfXEOhAL9cBcuAz4OPYAZgiOfem0tR84hqSVIlfDAJNGlS
	Fat5ct5S8NoLRZhp/6v2hBQonpNY0Cz43rOtQHd4vo57L6GRDn45NZ3aQdHJIkGLTgdEhl3F2zb
	bQ23KEggm+oBPSJeH5wbdIrRC8J9OZtk5JJedAUr7KjVZTeqgHW0w==
X-Received: by 2002:a05:7022:b053:20b0:14e:61bb:ec3d with SMTP id a92af1059eb24-165a21c3636mr1993743c88.16.1791437951948;
        Wed, 07 Oct 2026 22:39:11 -0700 (PDT)
Received: from MBP-Saravanan-D.civet-hops.ts.net ([2601:647:4380:3400:348d:5a62:5db7:75e2])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-16169249859sm10418363c88.15.2026.10.07.22.39.10
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 07 Oct 2026 22:39:11 -0700 (PDT)
From: Saravanan D <saravanand@crusoe.ai>
To: linux-nvme@lists.infradead.org
Cc: Saravanan D <saravanand@crusoe.ai>,
	kbusch@kernel.org,
	hch@lst.de,
	sagi@grimberg.me,
	axboe@kernel.dk,
	nilay@linux.ibm.com,
	dwagner@suse.de,
	linux-kernel@vger.kernel.org,
	iyamahata@crusoe.ai,
	kiyer@crusoe.ai,
	ganbalagane@crusoe.ai,
	sj@crusoe.ai
Subject: Re: [PATCH v4 0/2] nvme-tcp: allow setting per-queue io_cpu through sysfs
Date: Wed,  7 Oct 2026 22:39:04 -0700
Message-ID: <20261008053906.38005-1-saravanand@crusoe.ai>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260927070925.47209-1-saravanand@crusoe.ai>
References: <20260927070925.47209-1-saravanand@crusoe.ai>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261007_223913_654374_2C1B428D 
X-CRM114-Status: UNSURE (   6.40  )
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

The Sashiko review of this series [1] found lifecycle bugs in the
sysfs registration, including a use after free of ctrl->queues_kobj
after ops->free_ctrl() and a reference cycle that leaks the controller
on every disconnect. I will address all of its comments in v5, so
please hold off on applying v4.

[1] https://sashiko.dev/#/patchset/20260927070925.47209-1-saravanand%40crusoe.ai

Thanks,
Saravanan D.

