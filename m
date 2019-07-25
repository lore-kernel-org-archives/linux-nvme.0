From: minwoo.im.dev@gmail.com (Minwoo Im)
Date: Thu, 25 Jul 2019 22:14:22 +0900
Subject: [PATCH] nvme-pci: Use dev_get_drvdata where possible
In-Reply-To: <20190724122235.21639-1-hslester96@gmail.com>
References: <20190724122235.21639-1-hslester96@gmail.com>
Message-ID: <20190725131422.GA7289@minwoo-desktop>

On 19-07-24 20:22:35, Chuhong Yuan wrote:
> Instead of using to_pci_dev + pci_get_drvdata,
> use dev_get_drvdata to make code simpler.
> 
> Signed-off-by: Chuhong Yuan <hslester96 at gmail.com>

This looks good to me.

Reviewed-by: Minwoo Im <minwoo.im.dev at gmail.com>
