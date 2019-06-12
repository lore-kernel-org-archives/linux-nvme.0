From: keith.busch@gmail.com (Keith Busch)
Date: Wed, 12 Jun 2019 08:32:46 -0600
Subject: [PATCH] PCI: Add Intel remapped NVMe device support
In-Reply-To: <CAD8Lp45djPU_Ur8uCO2Y5Sbek_5N9QKkxLXdKNVcvkr6rFPLUQ@mail.gmail.com>
References: <20190610074456.2761-1-drake@endlessm.com>
 <CAOSXXT7OFzHeTxNqZ1sS6giRxhDcrUUnVjURWBiFUc5T_8p=MA@mail.gmail.com>
 <CAD8Lp45djPU_Ur8uCO2Y5Sbek_5N9QKkxLXdKNVcvkr6rFPLUQ@mail.gmail.com>
Message-ID: <CAOSXXT7H6HxY-za66Tr9ybRQyHsTdwwAgk9O2F=xK42MT8HsuA@mail.gmail.com>

On Mon, Jun 10, 2019@8:46 PM Daniel Drake <drake@endlessm.com> wrote:
> What's the specific problem that you see here?

Performance. Have you had a chance to benchmark these storage devices
comparing legacy vs MSI interrupts? I don't think anyone would chose
the slower one on purpose. These platforms have an option to disable
raid mode, so the kernel's current recommendation should be the user's
best option.
