From: rjw@rjwysocki.net (Rafael J. Wysocki)
Date: Thu, 08 Aug 2019 12:03:09 +0200
Subject: [PATCH v2 0/2] nvme-pci: Allow PCI bus-level PM to be used if ASPM is
 disabled
In-Reply-To: <20190731221956.GB15795@localhost.localdomain>
References: <4323ed84dd07474eab65699b4d007aaf@AUSX13MPC105.AMER.DELL.COM>
 <CAJZ5v0iDQ4=kTUgW94tKGt7oJzA_3uVU_M6HAMbNCRXwp_do8A@mail.gmail.com>
 <47415939.KV5G6iaeJG@kreacher> <20190730144134.GA12844@localhost.localdomain>
 <100ba4aff1c6434a81e47774ab4acddc@AUSX13MPC105.AMER.DELL.COM>
 <8246360B-F7D9-42EB-94FC-82995A769E28@canonical.com>
 <20190730191934.GD13948@localhost.localdomain>
 <7d3e0b8ba1444194a153c93faa1cabb3@AUSX13MPC105.AMER.DELL.COM>
 <20190730213114.GK13948@localhost.localdomain>
 <CAJZ5v0gxfeMN8eCNRjcXmUOkReVsdozb3EccaYMpnmSHu3771g@mail.gmail.com>
 <20190731221956.GB15795@localhost.localdomain>
Message-ID: <1921165.pTveHRX1Co@kreacher>

Hi All,

This series is equivalent to the following patch:

https://patchwork.kernel.org/patch/11083551/

posted earlier today.

It addresses review comments from Christoph by splitting the PCI/PCIe ASPM part
off to a separate patch (patch [1/2]) and fixing a few defects.

Thanks!
