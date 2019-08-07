From: hch@lst.de (Christoph Hellwig)
Date: Wed, 7 Aug 2019 12:43:53 +0200
Subject: [PATCH] nvme-pci: Do not prevent PCI bus-level PM from being used
In-Reply-To: <1893355.EP2830DdO9@kreacher>
References: <47415939.KV5G6iaeJG@kreacher>
 <20190730144134.GA12844@localhost.localdomain>
 <100ba4aff1c6434a81e47774ab4acddc@AUSX13MPC105.AMER.DELL.COM>
 <8246360B-F7D9-42EB-94FC-82995A769E28@canonical.com>
 <20190730191934.GD13948@localhost.localdomain>
 <7d3e0b8ba1444194a153c93faa1cabb3@AUSX13MPC105.AMER.DELL.COM>
 <20190730213114.GK13948@localhost.localdomain>
 <CAJZ5v0gxfeMN8eCNRjcXmUOkReVsdozb3EccaYMpnmSHu3771g@mail.gmail.com>
 <20190731221956.GB15795@localhost.localdomain> <1893355.EP2830DdO9@kreacher>
Message-ID: <20190807104353.GA11356@lst.de>

> +	if (pm_suspend_via_firmware() || !ctrl->npss || !pcie_aspm_enabled(pdev)) {



> +	mutex_lock(&aspm_lock);
> +	aspm_enabled = bridge->link_state ? bridge->link_state->aspm_enabled : 0;

Please fix the overly long lines..
