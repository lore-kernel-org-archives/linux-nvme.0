Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2545CD4851
	for <linux-nvme@archiver.kernel.org>; Sat, 16 May 2026 00:45:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lKyj+BgFWLyIjd7FQWgJlKDISSTkRJ7PSBxk5ZXeyDY=; b=dK3VWoY2MNJQwU65tmu3DfRgb1
	vHdfOBrXp1db79jB4V53neXQc7loFIMhBXf7cTKEZo9BB8/o6OEaoYjoLbWdmNLJXjcWIxer836fz
	IkgDNG6i0caYbchizLTLs85/lG0ZN8g12M9utg9rrI+DXiohyVm+wqcShyyaNIwYAxGrqL47szXCS
	DMPEONUmzLp/hJkRjwCud9i0vCrpXVnXvqdLsFz0FNfIEY5LnfUKKR4gR4x5pKk0CMT+6d8DLatpR
	P1kiIXwY+RLEpIUScoRdlOnVXNGN+BKkYC1izOVVNvNuEcJTsugP4PxpWqzJdVEesYADu8GVw4R1E
	BnxhmyRA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wO39a-00000009pFW-1KNf;
	Sat, 16 May 2026 00:45:18 +0000
Received: from mail-vk1-xa2f.google.com ([2607:f8b0:4864:20::a2f])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wO39X-00000009pF7-3AJ5
	for linux-nvme@lists.infradead.org;
	Sat, 16 May 2026 00:45:16 +0000
Received: by mail-vk1-xa2f.google.com with SMTP id 71dfb90a1353d-57602a2d80aso125102e0c.2
        for <linux-nvme@lists.infradead.org>; Fri, 15 May 2026 17:45:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778892314; cv=none;
        d=google.com; s=arc-20240605;
        b=AawkHViG1pnTVbMpfUFRF8O9sYW3GWW6f+cvGmPGTZeBKtLx+vaWqogkJnr21wDK2K
         uB/K1npJUGy610PigLoi1kKmGdTEVlCzQyiq1VygBvaf3vrr5YuhzMxcnJqZ7X8YHxvB
         l1H10Qx62kGEz41H4M1k5TQrPn45ox67YPWhJ4Y1DJwdAoiXzmgfK9RIr3SCe+y9gMpE
         Uj/P1A7djC1GfbjoXnH66cW/zlWDlUs4eUHqZrOvUJhvfI5wG4x9ox7QDfLwSSg3znPl
         t5Km6EqaBQxtBuig40MjkZwnQZAYEBPL0YCFP05cMeMDTNDJTMafvW/PimFbZ21tURZo
         Skpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lKyj+BgFWLyIjd7FQWgJlKDISSTkRJ7PSBxk5ZXeyDY=;
        fh=+Wzh/ndRNK1J42kNNcyPxXWKpvYtYYRzVnj2ptlGapQ=;
        b=MF1Q8rtx1fFLrVBFEagiWBLy9cAAzRVsgrMNVbk/zKAux4SVK8vdyrHe7N1pYQVpV6
         TAIfh8fZofJL9nQyWtSGW5z00yOBJEQQDZqCl5J+PvZCH+4fYhYMUhRGHfSlHOsea6tT
         gSLsxgTxjczjHozI2o6/ApMpwxiYfqAEFGFz0JMaa9Qa8bGrAdrs4iGmSoh7yqKAWqcG
         l9oNOXIHv//fs8LT75MLPrHAOgIGBmil+9u9UrT7CPtmgjAvrEdcioOOohWwS8+mV+07
         gwo68F8zmwcuWthOFXSZLwvgeMtnObh7eZTkI1paSK7GlDOLh0CwxkDPe3YttP8XlDVQ
         5BGg==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1778892314; x=1779497114; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lKyj+BgFWLyIjd7FQWgJlKDISSTkRJ7PSBxk5ZXeyDY=;
        b=Kho9GC4tD5mJxvizL2sIO6j6lC3hckfQcV0xjEXMjkG1LmAqJrpfF4Atf3G/Xo20nG
         54iWwx2jbOEPZVK58ZDf0Ww3UuulhKyv3LFz8Atyf0AkyRCMw2sAIiFFzQY/XZDiiLgb
         CeWxxRUOnmCberpZBy7HuE8dAgsi/0dSn0H8NRMM06dGieA+inpX2c9jTkDtmM6ek6mr
         pN2l3baxdpnf50kHTtbQlFqMwOZelclXKnGxPxCHXiis74VCekdzY/VIRT9ap2xTy+Uj
         knFkksaQh9auXqJpcSKXtmjZzxLRMzWn6DD5VIQuaXsO6RMUaZHtlmxE6IaZyCdgugkS
         C/GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778892314; x=1779497114;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lKyj+BgFWLyIjd7FQWgJlKDISSTkRJ7PSBxk5ZXeyDY=;
        b=Xt+lAKbCHgMh3bqcw+VGTfcSp8ktX5ldV2U23PzlBBQ/Kt72ia6ZI5MLRaRMR6QRx7
         eHruXsoZ38nuJVQsZ7RtRx9KCAEewRarl+jsxer/KcLlKNcAuI9/GwZkHVNXsl5rCBcg
         2P4lqU4E4vGAuPujdWuOmb42VtzzAjx7mQDPsr+DXm4EY946M1YMeaVVaX7JzZ9dggc8
         YitDV28GqUHoTt4c0L9Y+g1F2lTxfS/z+bHAHEPdlsk87NqTTXtJdNl7bMdn9HVrhZLJ
         jPskcZhqzrtptriiKFPzPY3SmAKcqNZzv90Yub1FA0TJm8d9XjO6NITZjfEULVCsyJ5y
         eYqQ==
X-Forwarded-Encrypted: i=1; AFNElJ8gJojOhmu9KxtaqB4/n3VT1TwD3dVAbr8aVFvCsc9SDgfU0VNCIYdhc3tcy9cQ7VlkyGuxGOATKf6z@lists.infradead.org
X-Gm-Message-State: AOJu0Yy0hGKh7ZDt+iF+102+UwrcdchIl2OkdbopRG7i85WwlwAjs5ca
	u9xOl0jCu/CM5l9Z8Qei6Eva4pU5fLd5XmEpDinmLZnIgqB5HjDlTXzl3tQbTfzBW0tfhMmJeXl
	GT0UYLOiNg6OfCeRQN3JusbFmP+2eeeFyKU78UoSmLaZFq11WZpDeyDST3RzjLPI=
X-Gm-Gg: Acq92OFgSqurwyl0TY7THKBG0N8npycfHcEvqPtd6bqeXZC0B0YGfkQN1dssGj1Ik0f
	khl1ZlwYTlTY1QBIKh3WxLZC3oJ18qhYtFQ+USrASqD856QdZ47kaB2bi32UgU/xyPwXoojFGas
	QNsRI4Yq9C5rjeq5JcyjJCXPGoUEpTTh0Mx4dckSRFDRn3ybXzA0hxk0TS4fK8wvtxwQk18U7CU
	3A0z6Vvq6lcQJmW6DxxzbHGhN5d6EFlgt57/r60W0LKj9cyTtHEzBFYMKtVkn4c1LcWbYzvaML6
	7VbfoVgajHZocyU5fij3XoKhJW8Buf9bSu9T/TbBsg/PPCbUjm/cO0DQQAX34o6LhOjP
X-Received: by 2002:a05:6122:614e:b0:575:362c:4789 with SMTP id
 71dfb90a1353d-5760c04afacmr4192977e0c.11.1778892314091; Fri, 15 May 2026
 17:45:14 -0700 (PDT)
MIME-Version: 1.0
References: <20260214042753.4073668-1-mkhalfella@purestorage.com>
 <20260214042753.4073668-14-mkhalfella@purestorage.com> <d6013719-8169-4ad0-bb05-a626a717e8b1@gmail.com>
 <20260326174011.GP3435530-mkhalfella@purestorage.com>
In-Reply-To: <20260326174011.GP3435530-mkhalfella@purestorage.com>
From: Randy Jennings <randyj@purestorage.com>
Date: Fri, 15 May 2026 17:45:02 -0700
X-Gm-Features: AVHnY4LGhzl5g_Zq7gvz-N65t3wuwLV_QpG7AbKlEHKhLwGN6XHR4RMnkASItDg
Message-ID: <CAPpK+O2a+0dBykDvZdoO47TzwWP1sxBgcT8+uFaTf_NKu3xZdQ@mail.gmail.com>
Subject: Re: [PATCH v3 13/21] nvme-fc: Use CCR to recover controller that hits
 an error
To: Mohamed Khalfella <mkhalfella@purestorage.com>
Cc: James Smart <jsmart833426@gmail.com>, Justin Tee <justin.tee@broadcom.com>, 
	Naresh Gottumukkala <nareshgottumukkala83@gmail.com>, Paul Ely <paul.ely@broadcom.com>, 
	Chaitanya Kulkarni <kch@nvidia.com>, Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>, 
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>, 
	Aaron Dailey <adailey@purestorage.com>, Dhaval Giani <dgiani@purestorage.com>, 
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260515_174515_806340_8013D4F9 
X-CRM114-Status: GOOD (  18.05  )
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

On Thu, Mar 26, 2026 at 10:40=E2=80=AFAM Mohamed Khalfella
<mkhalfella@purestorage.com> wrote:
>
> On Fri 2026-02-27 17:03:55 -0800, James Smart wrote:
> > On 2/13/2026 8:25 PM, Mohamed Khalfella wrote:

> > What bothers me in this process is - there are certainly conditions
> > where there is not connectivity loss  where FC can send things such as
> > the ABTS or a Disconnect LS that can inform the controller to start
> > terminating. Its odd that we skip this step and go directly to the CCR
> > reset to terminate the controller.  We should have been able to continu=
e
> > to send the things that start to directly tear down the controller whic=
h
> > can be happening in parallel with the CCR.
>
> Depending on how the target is implemented ABTS or Disconnect LS do not
> guarantee inflight IOs are terminated. CCR main point is terminate
> inflight IOs making it safe to retry failed IOs.

James, yes, there are circumstances where traffic on the connection
is flowing fine, and this request is just a problem child.  That is
the problem NVMe Cancel is trying to solve, and John is looking at
getting that wrapped into the code.  I would expect that FC ABTS
could just substitute for NVMe Cancel (if desired) when that change
comes.  For now, we are trying to overcome the data corruption, and
canceling/aborting an individual request is an important, but
subordinate, optimization.

Sincerely,
Randy Jennings

