Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01112C67871
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Oct 2022 23:41:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:To:Subject:
	Message-ID:Date:From:MIME-Version:Reply-To:Cc:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Z7ZjJtq4AHI9FxX3LUuDcCHBKj4iQLjdksmOp1H/5bA=; b=EVfzE3y1yhiV0Nfh2B/ZdT+v8U
	238nW0sWAuEhZ+xcVXPwYMuAaFs9uOntiMRffWqtHhOcYmDY5ZoTHEkn9M2kGG+lVFloLEVEum7A3
	lklHjDalkKurmVNXhqNQRb2X1WLmIWDZMyFmNoDEkbMaM9RculPou5SE7uDAvMc85l/tEjvt7o7m4
	KeukGNe+NApnNa3JlU8SY+RBOV5gGjMpQ0xp+3N1XnMCt85nD4Ex+WYy6+h8c9b7YDucXezkPXzUI
	L1VZUqT3khVk2aZeumETGW6gw9d6UV8y+LxniRCY+9px7hRz4IKUkxmX17eKPdad45i0Md71FaU/U
	+3j18Zeg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1on74B-003NLw-Ux; Mon, 24 Oct 2022 23:41:11 +0000
Received: from mail-oi1-x233.google.com ([2607:f8b0:4864:20::233])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1on749-003NLX-J3
	for linux-nvme@lists.infradead.org; Mon, 24 Oct 2022 23:41:11 +0000
Received: by mail-oi1-x233.google.com with SMTP id u15so12497737oie.2
        for <linux-nvme@lists.infradead.org>; Mon, 24 Oct 2022 16:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Z7ZjJtq4AHI9FxX3LUuDcCHBKj4iQLjdksmOp1H/5bA=;
        b=phBnK6bL5i5NyihSFh12lgif+UiW8QR+1zpp8MgfbH18fE3E3NBaJp4XK2D/oJqcSI
         zyn72e5/746P57wC/zF45ZmO+2f503J+zd+zeOIQF0uwOjppye7Bh5nkYuiJeoVqPLnm
         D+1jGEn0aOlPXGukonl5a3A2IGn+JUrOv0ioSs6rLScskvzy5HWSKoKNRfGQw9FXPAcp
         aAyb002CGqkRXduNVhL+6tL5blU3SX+m4LGLlVBMf3fVQy/EFFJapA4GJIYlqG/573j7
         svv+egH1E6HiN+Fw9C9BLnC8FTK0Eg2ZWm5tTlBPgnrULJtSsoU5SARqTq70/co/2sZY
         5zCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Z7ZjJtq4AHI9FxX3LUuDcCHBKj4iQLjdksmOp1H/5bA=;
        b=d8snHiGyqc4KlUMMyMv888FmRd8u7Ic0hBE6kPDkMKkFiI+bNGSP0CHrNVBLTfNO8F
         6kmCA78TWs6yGsH8iVQyrqptScYh3oBKbGkiFb9a9cOY62moMV4r2SytvIubvvXY4TeN
         EtOFopIKrpAnHNlr9f0ItOXgCq9KGCukwSMVfNgP/TJ3VWzpHO1uFGmwU9PGmfSNTAG4
         +eUpBZmOXGIE33rP+wKt5d/bkzn57iVucGpvy/Rc0WREXXfDQ4htbJOB1MUEcK0FdJLS
         Pwjh2KimvVgFtrDOLbkzddv1q4MbC5J8k5unmJR/39JSwq4Hw8MjNcZWqm9IL1ok6mCO
         O6VA==
X-Gm-Message-State: ACrzQf2+ts8+BsAzr9vuQgdqr+GU6Ft+dtf/BkL/hMEBuFe5YoxeUewL
	u8KaIMej5jB8mac//DHMj4umccD/l3Hygy8hN5aYASGjSUs=
X-Google-Smtp-Source: AMsMyM5bn3ZuhT+5d+jT4OxenDJcGv1pGKEfn1ZThPkUBp5e+Y6MT2RV18V6DfeJZmSN34JeVpEislF9arbsHQNZO+w=
X-Received: by 2002:a05:6808:1587:b0:355:3525:8ed with SMTP id
 t7-20020a056808158700b00355352508edmr17988340oiw.153.1666654867431; Mon, 24
 Oct 2022 16:41:07 -0700 (PDT)
MIME-Version: 1.0
From: Kevin Rowland <kevin.p.rowland@gmail.com>
Date: Mon, 24 Oct 2022 16:40:56 -0700
Message-ID: <CAHK3GzzKQcx0YktRhEOv4w=dbyOUC7K8yABAXL0zYqnHaQk6KQ@mail.gmail.com>
Subject: SSD low power state during system suspend
To: linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221024_164109_671578_843E1B30 
X-CRM114-Status: GOOD (  16.05  )
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

Hey all,

We're having a discussion in the PCI list about a panic during suspend
when PCIe ASPM is enabled on a link with an SSD at the other end [1].
I'm rooting around in the NVMe drivers now, so I wanted to ask some
specific questions here.

The motivation for enabling ASPM is so that we can put the downstream
SSD in its lowest power state (PS4 in our case), by getting past the
`pcie_aspm_enabled()` check in `nvme_suspend()`, which allows us to
call `nvme_set_power_state(ctrl, ctrl->npss)` [2].

If we don't enable ASPM, then the SSD stays in PS0, the PCIe layer
puts the endpoint controller in D3_HOT, and the SSD consumes more
power than we would like when the system is suspended. In fact, the
vendor says that the SSD should consume much less power that what
we've measured.

After enabling ASPM, the panic during suspend happens when attempting
to mask interrupts while the PCIe controller is unpowered and
unclocked, during `suspend_disable_secondary_cpus()`. One way around
this is to simply keep the PCIe controller powered and clocked until
later in the suspend process. The QCOM folks on this thread [3] had
some success doing this by postponing some clock operations to
`syscore_suspend()`, but I wasn't able to get a similar scheme working
on our NXP SoC.

Anyway, now I'm exploring other options to put the SSD in PS4 and
avoid the panic, without applying messy patches to the platform power
management logic. One thing I decided to try is to call
`nvme_set_power_state(ctrl, ctrl->npss)` during suspend, and then to
unconditionally call both `pci_load_saved_state(pdev, NULL)` and
`nvme_disable_prepare_reset()` after that; the latter calls
`nvme_pci_disable()`, which in turn disables and frees MSIs. I did
this by simply commenting out the `if()` condition here [4].

The way I see it, this puts the SSD in PS4, frees PCIe MSIs, and
allows the PCIe PM subsystem to put the endpoint in D3_HOT. On our
hardware we can't remove power from the SSD, so it stays in D3_HOT.

Experimentally this kind of halfway works - interrupts have been freed
during `nvme_disable_prepare_reset()` so we no longer attempt to mask
them during `suspend_disable_secondary_cpus()`, and I no longer see
any panic while suspending! I am waiting for current measurements to
see if the SSD is actually in PS4 and drawing less power.

Unfortunately, on resume, things go terribly wrong and the SSD doesn't
respond to requests for Identify Controller data:
```
[  139.130155] nvme 0001:01:00.0: nvme_resume()
[  199.484042] nvme nvme0: I/O 5 QID 0 timeout, disable controller
[  199.664294] nvme nvme0: Identify Controller failed (-4)
[  199.664309] nvme nvme0: Removing after probe failure status: -5
```

So, am I crazy to be pursuing this? Can I _theoretically_ put the SSD
in a lower power state, then call `nvme_disable_prepare_reset()` and
expect it to stay in the lower power state while the system suspends?
Should I keep investigating the Identify Controller timeout during
resume, or is this approach bound to fail?

Thanks,
Kevin

[1] https://lore.kernel.org/linux-pci/CAHK3GzwYmk6Fr6-YCjEmCweCPBdWJwHDz4Vc8CdX0xfT7b=-xQ@mail.gmail.com/
[2] https://elixir.bootlin.com/linux/v5.10.72/source/drivers/nvme/host/pci.c#L3096
[3] https://lore.kernel.org/linux-pci/1663669347-29308-2-git-send-email-quic_krichai@quicinc.com/
[4] https://elixir.bootlin.com/linux/v5.10.72/source/drivers/nvme/host/pci.c#L3100

