From: yogi43222@gmail.com (Yogi Wannabe)
Date: Fri, 6 Oct 2017 14:49:06 -0700
Subject: Missing interrupts in kernel 4.5.0-21.cavium.el7.aarch64
Message-ID: <CAGSHeY1uhgMT5oQBt8fxEzO1k=s9q9eBaFGm+oVt9a31_Ga9aA@mail.gmail.com>

Hi,

Our NVMe controller works fine with Kernel 3.9.xx. On kernel
4.5.0-21.cavium.el7.aarch64 we see some issues with interrupts.

Upon nvme driver load it, sends an Identify cmd.. The controller
processes the cmd and sends a completion interrupt. The driver does
not see this interrupt nor is it visible in /proc/interrupts. After
admin timeout duration, driver disables controller and calls
free_irq(). As soon as free_irq() is called, interrupt reaches driver
and nvme_irq() is called. The interrupt vector is usually 17.

Are there any known issues that could be causing this weird behavior?

TIA
Yogi
