From: lkp@intel.com (kbuild test robot)
Date: Wed, 28 Oct 2015 04:43:25 +0800
Subject: [PATCH v12 2/5] gennvm: Generic NVM manager
In-Reply-To: <1445957719-5368-3-git-send-email-m@bjorling.me>
Message-ID: <201510280433.4DrZfhFN%fengguang.wu@intel.com>

Hi Matias,

[auto build test ERROR on next-20151022 -- if it's inappropriate base, please suggest rules for selecting the more suitable base]

url:    https://github.com/0day-ci/linux/commits/Matias-Bj-rling/Support-for-Open-Channel-SSDs/20151027-230440
config: microblaze-allmodconfig (attached as .config)
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=microblaze 

All errors (new ones prefixed by >>):

   ERROR: "isa_io_base" [drivers/staging/comedi/drivers/dt2814.ko] undefined!
   ERROR: "isa_io_base" [drivers/staging/comedi/drivers/dt2811.ko] undefined!
   ERROR: "isa_io_base" [drivers/staging/comedi/drivers/dt2801.ko] undefined!
   ERROR: "isa_io_base" [drivers/staging/comedi/drivers/dmm32at.ko] undefined!
   ERROR: "isa_io_base" [drivers/staging/comedi/drivers/das800.ko] undefined!
   ERROR: "isa_io_base" [drivers/staging/comedi/drivers/das6402.ko] undefined!
   ERROR: "isa_io_base" [drivers/staging/comedi/drivers/das1800.ko] undefined!
   ERROR: "isa_io_base" [drivers/staging/comedi/drivers/das16m1.ko] undefined!
   ERROR: "isa_io_base" [drivers/staging/comedi/drivers/das16.ko] undefined!
   ERROR: "isa_io_base" [drivers/staging/comedi/drivers/das08.ko] undefined!
   ERROR: "isa_io_base" [drivers/staging/comedi/drivers/dac02.ko] undefined!
   ERROR: "isa_io_base" [drivers/staging/comedi/drivers/contec_pci_dio.ko] undefined!
   ERROR: "isa_io_base" [drivers/staging/comedi/drivers/comedi_parport.ko] undefined!
   ERROR: "isa_io_base" [drivers/staging/comedi/drivers/comedi_8255.ko] undefined!
   ERROR: "isa_io_base" [drivers/staging/comedi/drivers/comedi_8254.ko] undefined!
   ERROR: "isa_io_base" [drivers/staging/comedi/drivers/cb_pcimdda.ko] undefined!
   ERROR: "isa_io_base" [drivers/staging/comedi/drivers/cb_pcimdas.ko] undefined!
   ERROR: "isa_io_base" [drivers/staging/comedi/drivers/cb_pcidda.ko] undefined!
   ERROR: "isa_io_base" [drivers/staging/comedi/drivers/cb_pcidas.ko] undefined!
   ERROR: "isa_io_base" [drivers/staging/comedi/drivers/c6xdigio.ko] undefined!
   ERROR: "isa_io_base" [drivers/staging/comedi/drivers/amplc_pci263.ko] undefined!
   ERROR: "isa_io_base" [drivers/staging/comedi/drivers/amplc_pci236.ko] undefined!
   ERROR: "isa_io_base" [drivers/staging/comedi/drivers/amplc_pci230.ko] undefined!
   ERROR: "isa_io_base" [drivers/staging/comedi/drivers/amplc_pci224.ko] undefined!
   ERROR: "isa_io_base" [drivers/staging/comedi/drivers/amplc_pc263.ko] undefined!
   ERROR: "isa_io_base" [drivers/staging/comedi/drivers/amplc_dio200_common.ko] undefined!
   ERROR: "isa_io_base" [drivers/staging/comedi/drivers/aio_iiro_16.ko] undefined!
   ERROR: "isa_io_base" [drivers/staging/comedi/drivers/aio_aio12_8.ko] undefined!
   ERROR: "isa_io_base" [drivers/staging/comedi/drivers/adv_pci_dio.ko] undefined!
   ERROR: "isa_io_base" [drivers/staging/comedi/drivers/adv_pci1724.ko] undefined!
   ERROR: "isa_io_base" [drivers/staging/comedi/drivers/adv_pci1723.ko] undefined!
   ERROR: "isa_io_base" [drivers/staging/comedi/drivers/adv_pci1710.ko] undefined!
   ERROR: "isa_io_base" [drivers/staging/comedi/drivers/adq12b.ko] undefined!
   ERROR: "isa_io_base" [drivers/staging/comedi/drivers/adl_pci9118.ko] undefined!
   ERROR: "isa_io_base" [drivers/staging/comedi/drivers/adl_pci9111.ko] undefined!
   ERROR: "isa_io_base" [drivers/staging/comedi/drivers/adl_pci8164.ko] undefined!
   ERROR: "isa_io_base" [drivers/staging/comedi/drivers/adl_pci7x3x.ko] undefined!
   ERROR: "isa_io_base" [drivers/staging/comedi/drivers/adl_pci6208.ko] undefined!
   ERROR: "isa_io_base" [drivers/staging/comedi/drivers/addi_watchdog.ko] undefined!
   ERROR: "isa_io_base" [drivers/staging/comedi/drivers/addi_apci_3xxx.ko] undefined!
   ERROR: "isa_io_base" [drivers/staging/comedi/drivers/addi_apci_3501.ko] undefined!
   ERROR: "isa_io_base" [drivers/staging/comedi/drivers/addi_apci_3120.ko] undefined!
   ERROR: "isa_io_base" [drivers/staging/comedi/drivers/addi_apci_2200.ko] undefined!
   ERROR: "isa_io_base" [drivers/staging/comedi/drivers/addi_apci_2032.ko] undefined!
   ERROR: "isa_io_base" [drivers/staging/comedi/drivers/addi_apci_16xx.ko] undefined!
   ERROR: "isa_io_base" [drivers/staging/comedi/drivers/addi_apci_1564.ko] undefined!
   ERROR: "isa_io_base" [drivers/staging/comedi/drivers/addi_apci_1516.ko] undefined!
   ERROR: "isa_io_base" [drivers/staging/comedi/drivers/addi_apci_1500.ko] undefined!
   ERROR: "isa_io_base" [drivers/staging/comedi/drivers/addi_apci_1032.ko] undefined!
   ERROR: "isa_io_base" [drivers/scsi/qla2xxx/qla2xxx.ko] undefined!
   ERROR: "isa_io_base" [drivers/scsi/ppa.ko] undefined!
   ERROR: "isa_io_base" [drivers/scsi/nsp32.ko] undefined!
   ERROR: "isa_io_base" [drivers/scsi/mvsas/mvsas.ko] undefined!
   ERROR: "isa_io_base" [drivers/scsi/megaraid.ko] undefined!
   ERROR: "isa_io_base" [drivers/scsi/ips.ko] undefined!
   ERROR: "isa_io_base" [drivers/scsi/initio.ko] undefined!
   ERROR: "isa_io_base" [drivers/scsi/imm.ko] undefined!
   ERROR: "isa_io_base" [drivers/scsi/fdomain.ko] undefined!
   ERROR: "isa_io_base" [drivers/scsi/dmx3191d.ko] undefined!
   ERROR: "isa_io_base" [drivers/scsi/dc395x.ko] undefined!
   ERROR: "isa_io_base" [drivers/scsi/atp870u.ko] undefined!
   ERROR: "isa_io_base" [drivers/scsi/aic94xx/aic94xx.ko] undefined!
   ERROR: "isa_io_base" [drivers/scsi/aic7xxx/aic7xxx.ko] undefined!
   ERROR: "isa_io_base" [drivers/scsi/aic7xxx/aic79xx.ko] undefined!
   ERROR: "isa_io_base" [drivers/scsi/advansys.ko] undefined!
   ERROR: "isa_io_base" [drivers/scsi/a100u2w.ko] undefined!
   ERROR: "isa_io_base" [drivers/scsi/3w-xxxx.ko] undefined!
   ERROR: "isa_io_base" [drivers/rtc/rtc-bq4802.ko] undefined!
   ERROR: "isa_io_base" [drivers/platform/chrome/cros_ec_lpc.ko] undefined!
   ERROR: "isa_io_base" [drivers/parport/parport_pc.ko] undefined!
   ERROR: "isa_io_base" [drivers/net/wireless/hostap/hostap_plx.ko] undefined!
   ERROR: "isa_io_base" [drivers/net/wireless/atmel.ko] undefined!
   ERROR: "isa_io_base" [drivers/net/wan/lmc/lmc.ko] undefined!
   ERROR: "isa_io_base" [drivers/net/wan/farsync.ko] undefined!
   ERROR: "isa_io_base" [drivers/net/irda/vlsi_ir.ko] undefined!
   ERROR: "isa_io_base" [drivers/net/irda/donauboe.ko] undefined!
   ERROR: "isa_io_base" [drivers/net/hamradio/yam.ko] undefined!
   ERROR: "isa_io_base" [drivers/net/hamradio/baycom_ser_hdx.ko] undefined!
   ERROR: "isa_io_base" [drivers/net/hamradio/baycom_ser_fdx.ko] undefined!
   ERROR: "isa_io_base" [drivers/net/ethernet/via/via-rhine.ko] undefined!
   ERROR: "isa_io_base" [drivers/net/ethernet/ti/tlan.ko] undefined!
   ERROR: "isa_io_base" [drivers/net/ethernet/sis/sis900.ko] undefined!
   ERROR: "isa_io_base" [drivers/net/ethernet/sis/sis190.ko] undefined!
   ERROR: "isa_io_base" [drivers/net/ethernet/intel/e1000/e1000.ko] undefined!
   ERROR: "isa_io_base" [drivers/net/ethernet/hp/hp100.ko] undefined!
   ERROR: "isa_io_base" [drivers/net/ethernet/dec/tulip/de4x5.ko] undefined!
   ERROR: "isa_io_base" [drivers/net/ethernet/amd/pcnet32.ko] undefined!
   ERROR: "isa_io_base" [drivers/net/ethernet/8390/ne2k-pci.ko] undefined!
   ERROR: "isa_io_base" [drivers/net/ethernet/8390/8390.ko] undefined!
   ERROR: "isa_io_base" [drivers/net/ethernet/3com/3c59x.ko] undefined!
   ERROR: "isa_io_base" [drivers/net/can/sja1000/sja1000_isa.ko] undefined!
   ERROR: "isa_io_base" [drivers/net/can/cc770/cc770_isa.ko] undefined!
   ERROR: "isa_io_base" [drivers/net/arcnet/com90xx.ko] undefined!
   ERROR: "isa_io_base" [drivers/net/arcnet/com90io.ko] undefined!
   ERROR: "isa_io_base" [drivers/net/arcnet/com20020.ko] undefined!
   ERROR: "isa_io_base" [drivers/net/arcnet/com20020-pci.ko] undefined!
   ERROR: "isa_io_base" [drivers/misc/altera-stapl/altera-stapl.ko] undefined!
   ERROR: "isa_io_base" [drivers/message/fusion/mptbase.ko] undefined!
   ERROR: "isa_io_base" [drivers/media/radio/radio-maxiradio.ko] undefined!
   ERROR: "isa_io_base" [drivers/media/pci/dm1105/dm1105.ko] undefined!
>> ERROR: "__udivdi3" [drivers/lightnvm/gennvm.ko] undefined!
>> ERROR: "__umoddi3" [drivers/lightnvm/gennvm.ko] undefined!
   ERROR: "isa_io_base" [drivers/leds/leds-ot200.ko] undefined!
   ERROR: "isa_io_base" [drivers/isdn/hysdn/hysdn.ko] undefined!
   ERROR: "isa_io_base" [drivers/isdn/hisax/hisax_fcpcipnp.ko] undefined!
   ERROR: "isa_io_base" [drivers/isdn/hisax/hisax.ko] undefined!
   ERROR: "isa_io_base" [drivers/isdn/hisax/hfc4s8s_l1.ko] undefined!
   ERROR: "isa_io_base" [drivers/isdn/hardware/mISDN/w6692.ko] undefined!
   ERROR: "isa_io_base" [drivers/isdn/hardware/mISDN/speedfax.ko] undefined!
   ERROR: "isa_io_base" [drivers/isdn/hardware/mISDN/netjet.ko] undefined!
   ERROR: "isa_io_base" [drivers/isdn/hardware/mISDN/mISDNinfineon.ko] undefined!
   ERROR: "isa_io_base" [drivers/isdn/hardware/mISDN/hfcmulti.ko] undefined!
   ERROR: "isa_io_base" [drivers/isdn/hardware/mISDN/avmfritz.ko] undefined!
   ERROR: "isa_io_base" [drivers/isdn/hardware/eicon/divas.ko] undefined!
   ERROR: "isa_io_base" [drivers/isdn/hardware/avm/b1pci.ko] undefined!
   ERROR: "isa_io_base" [drivers/isdn/hardware/avm/b1dma.ko] undefined!
   ERROR: "isa_io_base" [drivers/isdn/hardware/avm/b1.ko] undefined!
   ERROR: "isa_io_base" [drivers/input/touchscreen/mk712.ko] undefined!
   ERROR: "isa_io_base" [drivers/input/serio/pcips2.ko] undefined!
   ERROR: "isa_io_base" [drivers/input/joystick/tmdc.ko] undefined!
   ERROR: "isa_io_base" [drivers/input/joystick/sidewinder.ko] undefined!
   ERROR: "isa_io_base" [drivers/input/joystick/joydump.ko] undefined!
   ERROR: "isa_io_base" [drivers/input/joystick/interact.ko] undefined!
   ERROR: "isa_io_base" [drivers/input/joystick/guillemot.ko] undefined!
   ERROR: "isa_io_base" [drivers/input/joystick/grip_mp.ko] undefined!
   ERROR: "isa_io_base" [drivers/input/joystick/grip.ko] undefined!
   ERROR: "isa_io_base" [drivers/input/joystick/gf2k.ko] undefined!
   ERROR: "isa_io_base" [drivers/input/joystick/cobra.ko] undefined!
   ERROR: "isa_io_base" [drivers/input/joystick/analog.ko] undefined!
   ERROR: "isa_io_base" [drivers/input/joystick/adi.ko] undefined!
   ERROR: "isa_io_base" [drivers/input/joystick/a3d.ko] undefined!
   ERROR: "isa_io_base" [drivers/input/gameport/ns558.ko] undefined!
   ERROR: "isa_io_base" [drivers/input/gameport/lightning.ko] undefined!
   ERROR: "isa_io_base" [drivers/input/gameport/gameport.ko] undefined!
   ERROR: "isa_io_base" [drivers/input/gameport/fm801-gp.ko] undefined!
   ERROR: "isa_io_base" [drivers/i2c/busses/i2c-viapro.ko] undefined!
   ERROR: "isa_io_base" [drivers/i2c/busses/i2c-via.ko] undefined!
   ERROR: "isa_io_base" [drivers/i2c/busses/i2c-sis96x.ko] undefined!
   ERROR: "isa_io_base" [drivers/i2c/busses/i2c-sis630.ko] undefined!
   ERROR: "isa_io_base" [drivers/i2c/busses/i2c-sis5595.ko] undefined!
   ERROR: "isa_io_base" [drivers/i2c/busses/i2c-piix4.ko] undefined!
   ERROR: "isa_io_base" [drivers/i2c/busses/i2c-parport-light.ko] undefined!
   ERROR: "isa_io_base" [drivers/i2c/busses/i2c-nforce2.ko] undefined!
   ERROR: "isa_io_base" [drivers/i2c/busses/i2c-isch.ko] undefined!
   ERROR: "isa_io_base" [drivers/i2c/busses/i2c-i801.ko] undefined!
   ERROR: "isa_io_base" [drivers/i2c/busses/i2c-amd8111.ko] undefined!
   ERROR: "isa_io_base" [drivers/i2c/busses/i2c-amd756.ko] undefined!
   ERROR: "isa_io_base" [drivers/i2c/busses/i2c-ali15x3.ko] undefined!
   ERROR: "isa_io_base" [drivers/i2c/busses/i2c-ali1563.ko] undefined!
   ERROR: "isa_io_base" [drivers/i2c/busses/i2c-ali1535.ko] undefined!
   ERROR: "isa_io_base" [drivers/hwmon/w83627hf.ko] undefined!
   ERROR: "isa_io_base" [drivers/hwmon/w83627ehf.ko] undefined!
   ERROR: "isa_io_base" [drivers/hwmon/vt8231.ko] undefined!
   ERROR: "isa_io_base" [drivers/hwmon/vt1211.ko] undefined!
   ERROR: "isa_io_base" [drivers/hwmon/via686a.ko] undefined!
   ERROR: "isa_io_base" [drivers/hwmon/smsc47m1.ko] undefined!
   ERROR: "isa_io_base" [drivers/hwmon/smsc47b397.ko] undefined!
   ERROR: "isa_io_base" [drivers/hwmon/sis5595.ko] undefined!
   ERROR: "isa_io_base" [drivers/hwmon/sch56xx-common.ko] undefined!
   ERROR: "isa_io_base" [drivers/hwmon/pc87427.ko] undefined!
   ERROR: "isa_io_base" [drivers/hwmon/pc87360.ko] undefined!
   ERROR: "isa_io_base" [drivers/hwmon/nct6775.ko] undefined!
   ERROR: "isa_io_base" [drivers/hwmon/nct6683.ko] undefined!
   ERROR: "isa_io_base" [drivers/hwmon/it87.ko] undefined!
   ERROR: "isa_io_base" [drivers/hwmon/f71882fg.ko] undefined!
   ERROR: "isa_io_base" [drivers/hwmon/f71805f.ko] undefined!
   ERROR: "isa_io_base" [drivers/hwmon/dme1737.ko] undefined!
   ERROR: "isa_io_base" [drivers/gpu/drm/qxl/qxl.ko] undefined!
   ERROR: "isa_io_base" [drivers/gpu/drm/cirrus/cirrus.ko] undefined!
   ERROR: "isa_io_base" [drivers/gpu/drm/bochs/bochs-drm.ko] undefined!
   ERROR: "isa_io_base" [drivers/gpio/gpio-vx855.ko] undefined!
   ERROR: "isa_io_base" [drivers/gpio/gpio-ts5500.ko] undefined!
   ERROR: "isa_io_base" [drivers/gpio/gpio-sch311x.ko] undefined!
   ERROR: "isa_io_base" [drivers/gpio/gpio-amd8111.ko] undefined!
   ERROR: "isa_io_base" [drivers/char/tpm/tpm_atmel.ko] undefined!
   ERROR: "isa_io_base" [drivers/char/ipmi/ipmi_si.ko] undefined!
   ERROR: "isa_io_base" [drivers/block/paride/on26.ko] undefined!
   ERROR: "isa_io_base" [drivers/block/paride/on20.ko] undefined!
   ERROR: "isa_io_base" [drivers/block/paride/ktti.ko] undefined!
   ERROR: "isa_io_base" [drivers/block/paride/kbic.ko] undefined!
   ERROR: "isa_io_base" [drivers/block/paride/frpw.ko] undefined!
   ERROR: "isa_io_base" [drivers/block/paride/friq.ko] undefined!
   ERROR: "isa_io_base" [drivers/block/paride/fit3.ko] undefined!
   ERROR: "isa_io_base" [drivers/block/paride/fit2.ko] undefined!
   ERROR: "isa_io_base" [drivers/block/paride/epia.ko] undefined!
   ERROR: "isa_io_base" [drivers/block/paride/epat.ko] undefined!
   ERROR: "isa_io_base" [drivers/block/paride/dstr.ko] undefined!
   ERROR: "isa_io_base" [drivers/block/paride/comm.ko] undefined!
   ERROR: "isa_io_base" [drivers/block/paride/bpck6.ko] undefined!
   ERROR: "isa_io_base" [drivers/block/paride/bpck.ko] undefined!
   ERROR: "isa_io_base" [drivers/block/paride/aten.ko] undefined!
   ERROR: "isa_io_base" [drivers/atm/zatm.ko] undefined!
   ERROR: "isa_io_base" [drivers/atm/horizon.ko] undefined!
   ERROR: "isa_io_base" [drivers/atm/ambassador.ko] undefined!
   ERROR: "isa_io_base" [drivers/ata/pata_sc1200.ko] undefined!
   ERROR: "isa_io_base" [drivers/ata/pata_pdc202xx_old.ko] undefined!
   ERROR: "isa_io_base" [drivers/ata/pata_optidma.ko] undefined!
   ERROR: "isa_io_base" [drivers/ata/pata_legacy.ko] undefined!
   ERROR: "isa_io_base" [drivers/ata/pata_hpt3x2n.ko] undefined!
   ERROR: "isa_io_base" [drivers/ata/pata_hpt37x.ko] undefined!
   ERROR: "isa_io_base" [drivers/ata/pata_cypress.ko] undefined!
   ERROR: "isa_io_base" [drivers/ata/pata_cmd64x.ko] undefined!

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 42868 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-nvme/attachments/20151028/f8c8a75d/attachment-0001.obj>
