Return-Path: <SRS0=DfP6=K5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEE51C47096
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Jun 2021 17:17:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC214600D3
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Jun 2021 17:17:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC214600D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=d9wk8I34uPeqmwfOBiSyCbZDSmYBOVHsKhHArrPZFDM=; b=q6MsMzKqGJNXeR
	+JMSfOvixnF77u5VSTdgF8WV2zJ4Q9Qv3MyuTBKzfHXhlwDrNiKkocvnPWI01N7EQQZ2l+ukUVMcu
	he4OjbL6DAhWvVijEnt2sd6zBfoEIZehPDZW5UgYuIVMAnHI2elXqiJTRw0MYZ3hbLyR77ORKwCQu
	GWc8bfRBMlr+g4jb0e008qVmTlDgIaJ4L31PsD1TpE1uslMxFVQxlrIiP8Nub8O6/kZTfSJpUd21/
	NfxsSa5u11HvA5WNA2UwuoQMfULKWbZnBcZtseV8+UwvpJDyFtApCCa859e1JkGg6qe4BEAJZLviT
	oYhxzg5Du/j8OhpVZ0fA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1loqyZ-009oUa-BR; Thu, 03 Jun 2021 17:17:47 +0000
Received: from mail-qk1-x731.google.com ([2607:f8b0:4864:20::731])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1loquV-009mmB-5H
 for linux-nvme@lists.infradead.org; Thu, 03 Jun 2021 17:13:36 +0000
Received: by mail-qk1-x731.google.com with SMTP id o27so6647334qkj.9
 for <linux-nvme@lists.infradead.org>; Thu, 03 Jun 2021 10:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=dV2nvNFqWCItqaPHOOaQlyC8Sahyat7unUPVc/qQTb0=;
 b=q/uyctJuVSawxJTjQwcklgDmZWijiqGU5hk4GnWdbpHEAYWCz6RTkJIQg90XNjURQY
 oVpatxMEP/WTlxM9UeL1Tw1YQG1KYPwR8rVMCXxLcL15oiJAbWpidYzyApW+Q3FMtwjz
 gGLKoDU9wZFdzKnn/ddV4JYOaM9exAl9nX9+Erp60Y+kqpQSB22TbleIWAOqUJ2nYYHM
 QGpOBTVEG45Ej4ACHWIm3Ugc6esxig+3CyJfUgRSiGxy6AO7cCgi0mvCHKsDCfVUN7kz
 /wOFZE1wCfyUvE+YRh6NZdDf4S/tOkwgfz9qONhNEssVB+UbYhKoxCjzyTP7HPipjvED
 /uww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
 :references:mime-version:content-disposition:in-reply-to;
 bh=dV2nvNFqWCItqaPHOOaQlyC8Sahyat7unUPVc/qQTb0=;
 b=MDB0pMepKk9KrLRgeyE3X19ROPCi6T10NOOD4Bw8ZNfARCjDeK8zjaeH9LU+1AXeOF
 nLgcbyCdSZky3ffAjC1hjsLyUmZ6BaGSofEXBFSBofnrOIlsA3RNckuxKdryy9ywI26l
 vKRDuWfMNP0h06jyxLfnSg2tXFSvhT910aAm/uI0fmSSILQ797u4Jak7au9RSgw95biA
 TbYi410qFAfeBkkCW73U1XksSkSAzDjRDp6I7O5mYLXPzYxAsrpOrV4XonLqwguc5/fS
 AnbtCI1nRkUAWUBc00GKIxai5LUfJRB39g6Yw3Aw043jBZNv09wSUwHM9xnDO718+gan
 t5YQ==
X-Gm-Message-State: AOAM530jiXCPU/ylrxJqDdOkZidq+REdziwtyci6kV/dVmRr49UU8M2f
 lyc8PJNxEIZXjwB1Xgpeq5B5PjGs5RJ1CA==
X-Google-Smtp-Source: ABdhPJzg1+W24yf1MiTVbm2XpyVW6BbFpyPinuEE2R4B5bav57ttUworCcoTkXayBkYZIpOqoOwucw==
X-Received: by 2002:a05:620a:1198:: with SMTP id
 b24mr263594qkk.212.1622740411182; 
 Thu, 03 Jun 2021 10:13:31 -0700 (PDT)
Received: from localhost ([199.192.137.73])
 by smtp.gmail.com with ESMTPSA id m4sm2050209qtg.21.2021.06.03.10.13.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Jun 2021 10:13:30 -0700 (PDT)
Date: Thu, 3 Jun 2021 13:13:29 -0400
From: Tejun Heo <tj@kernel.org>
To: Muneendra <muneendra.kumar@broadcom.com>
Cc: linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
 linux-nvme@lists.infradead.org, hare@suse.de, jsmart2021@gmail.com,
 emilne@redhat.com, mkumar@redhat.com
Subject: Re: [PATCH v10 01/13] cgroup: Added cgroup_get_from_id
Message-ID: <YLkNufxDIv3Mlle6@slm.duckdns.org>
References: <1619562897-14062-1-git-send-email-muneendra.kumar@broadcom.com>
 <1619562897-14062-2-git-send-email-muneendra.kumar@broadcom.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1619562897-14062-2-git-send-email-muneendra.kumar@broadcom.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210603_101335_238206_83B3157B 
X-CRM114-Status: GOOD (  12.22  )
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

On Wed, Apr 28, 2021 at 04:04:45AM +0530, Muneendra wrote:
> Added a new function cgroup_get_from_id  to retrieve the cgroup
> associated with cgroup id.
> Exported the same as this can be used by blk-cgorup.c
> 
> Added function declaration of cgroup_get_from_id in cgorup.h
> 
> This patch also exported the function cgroup_get_e_css
> as this is getting used in blk-cgroup.h
> 
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> Signed-off-by: Muneendra <muneendra.kumar@broadcom.com>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
