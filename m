Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E2A1C83F05
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Jul 2025 12:11:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:MIME-Version:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=MZkZRlr25YbPqB2HwXUZRwm4fw7iqNH9MdAMyL+S4cg=; b=rTjpgUCm5F829JLLCMH9PYBrXJ
	emnyTEHC2LqvnhT+Eoqd86vPLxhGiE5z4xITW86ez5voztMHu+MfJkWU+2YBZ1vHea35rBhJPxIJm
	IWnh4nmUV9TZ5SpJ3Yf5dN+h04O0ZuoA7WC8DQoiKeXowK7pqdY+IsZV2Ug5AzSzZBn236t7EuWss
	RR7vB2kHg4GWUaCkc2JtYcyO4exiKtoruuELL567pZdNhBd53/t+XDR0Ttv55lGsfmH+6Dl4dZdp+
	FUZk2vF5RhiVtuIX6xcx8JW2LF31Lt2+i0nEddObNB0+60g2qQvafn0jJbYbJZUeVJLlnZt8HnOEr
	OUSFgG9A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uWwJV-00000008GAl-2jRE;
	Wed, 02 Jul 2025 12:11:45 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uWvPJ-000000085pw-3dVD
	for linux-nvme@lists.infradead.org;
	Wed, 02 Jul 2025 11:13:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751454819;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=MZkZRlr25YbPqB2HwXUZRwm4fw7iqNH9MdAMyL+S4cg=;
	b=CCofSR2dYV7zY3dPj36++ksggH8sOYBta6/aLdP1Osa2GVSs9yyUMt+nj9F0NzVyIDzMxg
	K/fvU/Kqrobsxf4ZKqyB0SWKzwKRBdlo72mzYI1glGKAZ+fTQksyGb1HURrmPJiFEOL/rD
	Ax4mDLRNCG6adyRzhT7l7vjB6VkNN00=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-504-Cjbzn3eLOfa_NHf002YrQg-1; Wed, 02 Jul 2025 07:13:38 -0400
X-MC-Unique: Cjbzn3eLOfa_NHf002YrQg-1
X-Mimecast-MFC-AGG-ID: Cjbzn3eLOfa_NHf002YrQg_1751454817
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-32b37b118a3so25001881fa.3
        for <linux-nvme@lists.infradead.org>; Wed, 02 Jul 2025 04:13:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751454817; x=1752059617;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MZkZRlr25YbPqB2HwXUZRwm4fw7iqNH9MdAMyL+S4cg=;
        b=h2d4c03vVbMs8i2pXdVVkDasZG03JJXwqJVg5kCU9T8jERMjwmy6RNVUkpSiwikS60
         6mPykpCHQ8Q7bSCWkXM+C/D2/MKCBimnRlC056glIKTtoEy+WpRxQt3jXT64wma7KePP
         1gJ4fWtkklbN6pDaQeDN7OsvC04D32ndKw5cWaJ0eR7M2HYtYfJk1ZTjcSjsXen+UBjD
         aA/4qEAL3f3EkbN+2u13l2g7zOywQxubx2T94EgKoqJ7cFDmfTlyDx2JCsym+gHkK00g
         /f2f3sqybVMTEchz1dwbTqn58j40+y81tUcqFmXtUW7R39De0vsp43DvKjvVJiYNmQaA
         Orug==
X-Forwarded-Encrypted: i=1; AJvYcCVivz5/y+rW0S/wmX0dTpe1duUcGxYaucwKAT8+LSnOL+eJe4YRDGMy+OO7Eaa5qsPEa/Hc5QDyJAYk@lists.infradead.org
X-Gm-Message-State: AOJu0Yxk3J8QkNR3jGoCyuk7JaHVoAqUQPH9zIdXALjuxsdrlRo0pJOn
	y6aEYwgbH4/vE6WVILd0EZS3MqzuQlPwvEOU4pCJzYO8lee5iiIywEBpzddDEjlpaBkVuTQmHtw
	H7SaIVTPUUTazCnh+35oydXc3kcq6Xk4xu5pr6S81YVnzY9XDjmT6EwMDgl99hJGZ093Y1SQZg2
	pRUu657eKulmpdwYTIQb7d2Wh99ziEwI5FfoBCDj+2mt4=
X-Gm-Gg: ASbGncvqJ1SA3nmNBQp9f0xJ6gx8k5eWXMBJlxELSEmkmr9ig9W8GgUWcFZqIASER5J
	9NYkwrMKl2leWNCvK5iJnxWU37QO4frpu8Q55HpUi6FHAarvNhTqymwDJrT+Z6rNg0AvJ1NJ7Y7
	amGZ6g
X-Received: by 2002:a2e:300b:0:b0:329:39cd:8d25 with SMTP id 38308e7fff4ca-32e0009b9cemr7171991fa.33.1751454816748;
        Wed, 02 Jul 2025 04:13:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEGLgCNulf2JBPoF6IitYZrvd3Dqb+lhUMrHqbfYNPMJuW71OuJ6YxnkSlKEdWOuwrXbgMPj8GOIkJ+9uW0u9Y=
X-Received: by 2002:a2e:300b:0:b0:329:39cd:8d25 with SMTP id
 38308e7fff4ca-32e0009b9cemr7171881fa.33.1751454816291; Wed, 02 Jul 2025
 04:13:36 -0700 (PDT)
MIME-Version: 1.0
From: Yi Zhang <yi.zhang@redhat.com>
Date: Wed, 2 Jul 2025 19:13:24 +0800
X-Gm-Features: Ac12FXzxl_rJVCxsjww60zBQtZjiqEECF25ia06iPv4bvMa4hbQaNxYHeS7V0Bk
Message-ID: <CAHj4cs_Ckhz4sL5k5ug_Dc5XfjSo9QDRSrHMfBj2XYGm_gb2+g@mail.gmail.com>
Subject: [bug report] nvme4: inconsistent AWUPF, controller not added (0/7).
To: linux-block <linux-block@vger.kernel.org>, 
	"open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>
Cc: Christoph Hellwig <hch@lst.de>, John Garry <john.g.garry@oracle.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: BjrD6_K2fovyBfMArSZVnESceTOshf6wE6aoPxAGKjg_1751454817
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250702_041341_972758_7294912F 
X-CRM114-Status: UNSURE (   6.77  )
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

Hi Christoph

I found this failure on one Samsung NVMe disk[1] with the latest
linux-block/for-next. Here is the reproducer and dmesg log.
Please help check it and let me know if you need any info/test. Thanks.

[1]
SAMSUNG MZQL2960HCJR-00A07 (PM9A3)
[2]
+ nvme format -l1 -f /dev/nvme4n1
Success formatting namespace:1
+ nvme reset /dev/nvme4
Reset: Network dropped connection on reset

dmesg:
[  751.872864] nvme nvme4: rescanning namespaces.
[  752.177475] nvme nvme4: resetting controller
[  752.221030] nvme nvme4: inconsistent AWUPF, controller not added (0/7).
[  752.227653] nvme nvme4: Disabling device after reset failure: -22

-- 
Best Regards,
  Yi Zhang


