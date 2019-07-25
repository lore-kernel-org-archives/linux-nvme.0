From: akinobu.mita@gmail.com (Akinobu Mita)
Date: Thu, 25 Jul 2019 23:24:36 +0900
Subject: [PATCH v5 2/4] dt-bindings: thermal: nvme: Add binding
 documentation
In-Reply-To: <20190722221645.GA32515@bogus>
References: <1561990354-4084-1-git-send-email-akinobu.mita@gmail.com>
 <1561990354-4084-3-git-send-email-akinobu.mita@gmail.com>
 <20190722221645.GA32515@bogus>
Message-ID: <CAC5umyh5d7Ya-Ou8BZmPfpXKT+WkMCWnRKkCw8xhe9upNKqVbg@mail.gmail.com>

2019?7?23?(?) 7:16 Rob Herring <robh at kernel.org>:
>
> On Mon, Jul 01, 2019@11:12:32PM +0900, Akinobu Mita wrote:
> > Add thermal binding documentation for NVMe temperature sensor.
> >
> > Cc: Rob Herring <robh at kernel.org>
> > Cc: Zhang Rui <rui.zhang at intel.com>
> > Cc: Eduardo Valentin <edubezval at gmail.com>
> > Cc: Daniel Lezcano <daniel.lezcano at linaro.org>
> > Cc: Keith Busch <kbusch at kernel.org>
> > Cc: Jens Axboe <axboe at fb.com>
> > Cc: Christoph Hellwig <hch at lst.de>
> > Cc: Sagi Grimberg <sagi at grimberg.me>
> > Cc: Minwoo Im <minwoo.im.dev at gmail.com>
> > Cc: Kenneth Heitke <kenneth.heitke at intel.com>
> > Cc: Chaitanya Kulkarni <Chaitanya.Kulkarni at wdc.com>
> > Signed-off-by: Akinobu Mita <akinobu.mita at gmail.com>
> > ---
> > * v5
> > - New patch
> >
> >  Documentation/devicetree/bindings/thermal/nvme.txt | 56 ++++++++++++++++++++++
> >  1 file changed, 56 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/thermal/nvme.txt
> >
> > diff --git a/Documentation/devicetree/bindings/thermal/nvme.txt b/Documentation/devicetree/bindings/thermal/nvme.txt
> > new file mode 100644
> > index 0000000..60b90de
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/thermal/nvme.txt
> > @@ -0,0 +1,56 @@
> > +Binding for NVMe temperature sensor
> > +
> > +An NVMe controller reports up to nine temperature values in the SMART / Health
> > +log.
> > +
> > +Required properties:
> > +- reg: A five-cell address encoded as (phys.hi phys.mid phys.lo size.hi
> > +  size.lo). phys.hi should contain the device's BDF (Bus/Device/Function)
> > +  as 0b00000000 bbbbbbbb dddddfff 00000000. The other cells should be zero.
> > +  See also Documentation/devicetree/bindings/pci/pci.txt
> > +
> > +- #thermal-sensor-cells: Must be 1. See ./thermal.txt for a description.
> > +  In the thermal-sensors property, the sensor ID 0 for composite temperature,
> > +  1 through 8 for NVMe temperature sensor N.
> > +
> > +Example:
> > +
> > +&pcie0 {
> > +     ...
> > +     nvme: nvme at 0,0 {
> > +             reg = <0x0000 0 0 0 0>;
> > +             #address-cells = <3>;
> > +             #size-cells = <2>;
> > +
> > +             nvmetemp: nvmetemp {
> > +                     reg = <0x0000 0 0 0 0>; /* DEVFN = 0x00 (0:0) */
>
> I'm not sure this is really valid PCI addressing as the parent has the
> same address.
>
> > +                     #thermal-sensor-cells = <1>;
>
> Can't you just put this in the parent? Is this really a separate
> addressable device from the parent?

How about this?

&pcie0 {
...
        pci-bridge at 0 {
                reg = <0x00000 0 0 0 0>;
                #address-cells = <3>;
                #size-cells = <2>;

                nvme: nvme at 0,0 {
                        reg = <0x10000 0 0 0 0>;
                        #thermal-sensor-cells = <1>;
                };
        };
};

and

&thermal_zones {
...
thermal-sensors = <&nvme 0>;
};

I tested this with the RockPro64 and edited
arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dts.

$ lspci
00:00.0 PCI bridge: Fuzhou Rockchip Electronics Co., Ltd Device 0100
01:00.0 Non-Volatile memory controller: Micron/Crucial Technology
Device 2263 (rev 03)

$ lspci -tv
-[0000:00]---00.0-[01]----00.0  Micron/Crucial Technology Device 2263
