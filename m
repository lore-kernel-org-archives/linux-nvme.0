Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA5BEC25B67
	for <linux-nvme@archiver.kernel.org>; Fri, 27 Oct 2023 12:18:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Xmv2nCArh9nUm4IgBkMr7LUQxYfIG4aI0QO4i8iZNFg=; b=LB2XE6oiA9cc3S9dSCZbGQo9wa
	JEUhEQTT10bnNn/2R8osmZsAbvCFZHv08eZlxwhQ73fXIzsT3f6YUDmZP31PQN3dDyGR3IRmqB4kG
	SFb5UbIjy2TsLfVm9J43HV7JJVgtFUOkCwCcTyXg6qrXp1hN6ZsBGhx/8B6nNrGhP4zerUNex3N9s
	ATszDSW7epoTtIpYgff1UK3XoFNQRPgQsLf1dqO6wfwzLf9G5GVmB8Zp8zLjsqLnZeOnsZxQyVt6P
	pHSd/wF1NZh0izTpqERJHfdT8yYjlHqucSz8LJznv5B8hEUCjrUF2mbJ8WlDNLUwdxEXSp+z8nl9a
	h/XntsGw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qwLnG-00GN6z-1F;
	Fri, 27 Oct 2023 12:18:26 +0000
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qwLnD-00GN6b-2i
	for linux-nvme@lists.infradead.org;
	Fri, 27 Oct 2023 12:18:25 +0000
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-40859c464daso16105715e9.1
        for <linux-nvme@lists.infradead.org>; Fri, 27 Oct 2023 05:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698409100; x=1699013900; darn=lists.infradead.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Xmv2nCArh9nUm4IgBkMr7LUQxYfIG4aI0QO4i8iZNFg=;
        b=MQ/hcLpCnItt6ey4+YwO+MYqaEK3w4bKVjWN7JciB9ETHN8VVJQEKxrVgohaxwPI9U
         bXSnRtQW1Ncz8rgVfncL+cr+DYHSXP5XCngcEnRZOIaAsWJ2NHXaFwRVTkKFZgaKWS2x
         cBlNf38wZHBIvizrei6/+eI8DRjEQQ4H5Kqmngq2Sw6x919yoNyxtpEduYbOJJ8C+AvW
         6gV+yH/AxYpEezVuZGEI0vRdVDYqX3KOlkTqr103p/+LN5SOGRX295biLVZSUUrn5DQ8
         F3fjqh4sSN9wL8xgMGlzDTQlNaeNL1fRJ8pbrDBVTCfVQ0XoDUzFVON4OyI1p031MAKp
         lASQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698409100; x=1699013900;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Xmv2nCArh9nUm4IgBkMr7LUQxYfIG4aI0QO4i8iZNFg=;
        b=jfge0N0vBICK5ChgTDJ1dWWu6VGqsciTIkR5LsHyfVFRh9N6AyIahKe1In1iJN/jur
         8lNlQ7q8oFGk8uOdMj3yL+jJ76yS6ks3xXOb3p58tHUY1Xp8r6k/OMgGApFj9HAcf78a
         uVqF+sEkjwsLXl0Nt+100sTXOLaTW2+yRCx0OxkB5GKCokrN8kI5rruSVuggm9Xnmopa
         SdKeWVAn2z22dZ/JoVWfSmJnMrawZh8P7zFlhA9mzq29VVA4Py7Wc/XTrp4w1xs7ESlA
         yw0OU8eY775O32Y55+kCV0mvB6rKN/Dn7X8a+eE/qXUZwvaw7ybv9Se73FNE1TP763V9
         YCUw==
X-Gm-Message-State: AOJu0YxCmaW9C/GUTN4XDkDfK2Q435JVgS+hdQdEXaPdwATkJxsTztAc
	Aw5x541Cz5N0AXNGIgL5cNKBis3RxcdYumTsas4=
X-Google-Smtp-Source: AGHT+IGWiEV/osmYTM1ilDP+V2gzvOsW3uMCY6IiLQSCv6ONwnDu4WyYIeG3dLKqgqO/gSBt+c661A==
X-Received: by 2002:a05:600c:1e06:b0:409:c1e:7fe8 with SMTP id ay6-20020a05600c1e0600b004090c1e7fe8mr2340196wmb.19.1698409100068;
        Fri, 27 Oct 2023 05:18:20 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id t3-20020a1c7703000000b004042dbb8925sm4912086wmi.38.2023.10.27.05.18.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Oct 2023 05:18:19 -0700 (PDT)
Date: Fri, 27 Oct 2023 15:18:16 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: jsmart2021@gmail.com
Cc: linux-nvme@lists.infradead.org
Subject: [bug report] nvme-fc: address target disconnect race conditions in
 fcp io submit
Message-ID: <c39b9d25-55d8-45d5-b689-416341b326c2@moroto.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231027_051823_881528_4473C6C7 
X-CRM114-Status: UNSURE (   5.51  )
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

Hello James Smart,

The patch 8b25f351929b: "nvme-fc: address target disconnect race
conditions in fcp io submit" from Jul 18, 2017 (linux-next), leads to
the following Smatch static checker warning:

	drivers/nvme/host/fc.c:2788 nvme_fc_start_fcp_op()
	error: dereferencing freed memory 'ctrl'

drivers/nvme/host/fc.c
    2781                 if (!(op->flags & FCOP_FLAGS_AEN)) {
    2782                         nvme_fc_unmap_data(ctrl, op->rq, op);
    2783                         nvme_cleanup_cmd(op->rq);
    2784                 }
    2785 
    2786                 nvme_fc_ctrl_put(ctrl);
                                          ^^^^
The nvme_fc_ctrl_put() function drops a refcound and potentially frees
ctrl.

    2787 
--> 2788                 if (ctrl->rport->remoteport.port_state == FC_OBJSTATE_ONLINE &&
                             ^^^^^^
Use after free?

    2789                                 ret != -EBUSY)
    2790                         return BLK_STS_IOERR;
    2791 
    2792                 return BLK_STS_RESOURCE;
    2793         }
    2794 
    2795         return BLK_STS_OK;
    2796 }

regards,
dan carpenter

