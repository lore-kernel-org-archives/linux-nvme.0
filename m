From: lkp@intel.com (kbuild test robot)
Date: Tue, 13 Mar 2018 06:48:59 +0800
Subject: [PATCH 12/13] qla2xxx: Fix Async GPN_FT for FCP and FC-NVMe scan
In-Reply-To: <20180312181650.20704-13-himanshu.madhani@cavium.com>
References: <20180312181650.20704-13-himanshu.madhani@cavium.com>
Message-ID: <201803130658.VnuHeuUh%fengguang.wu@intel.com>

Hi Quinn,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on next-20180309]
[also build test WARNING on v4.16-rc5]
[cannot apply to v4.16-rc4 v4.16-rc3 v4.16-rc2]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Himanshu-Madhani/qla2xxx-Fixes-for-FC-NVMe/20180313-055925
config: i386-randconfig-x078-201810 (attached as .config)
compiler: gcc-7 (Debian 7.3.0-1) 7.3.0
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

Note: it may well be a FALSE warning. FWIW you are at least aware of it now.
http://gcc.gnu.org/wiki/Better_Uninitialized_Warnings

All warnings (new ones prefixed by >>):

   Cyclomatic Complexity 1 arch/x86/include/asm/atomic.h:atomic_read
   Cyclomatic Complexity 1 arch/x86/include/asm/atomic.h:atomic_inc
   Cyclomatic Complexity 1 arch/x86/include/asm/atomic.h:atomic_dec
   Cyclomatic Complexity 1 arch/x86/include/asm/paravirt.h:arch_local_save_flags
   Cyclomatic Complexity 1 arch/x86/include/asm/irqflags.h:arch_irqs_disabled_flags
   Cyclomatic Complexity 1 include/linux/spinlock.h:spinlock_check
   Cyclomatic Complexity 1 include/linux/spinlock.h:spin_unlock_irqrestore
   Cyclomatic Complexity 2 include/linux/workqueue.h:to_delayed_work
   Cyclomatic Complexity 1 include/linux/completion.h:__init_completion
   Cyclomatic Complexity 1 include/linux/dma-debug.h:debug_dma_alloc_coherent
   Cyclomatic Complexity 1 include/linux/dma-debug.h:debug_dma_free_coherent
   Cyclomatic Complexity 1 arch/x86/include/asm/dma-mapping.h:get_arch_dma_ops
   Cyclomatic Complexity 4 include/linux/dma-mapping.h:get_dma_ops
   Cyclomatic Complexity 7 include/linux/dma-mapping.h:dma_alloc_attrs
   Cyclomatic Complexity 71 include/linux/dma-mapping.h:dma_free_attrs
   Cyclomatic Complexity 1 include/linux/dma-mapping.h:dma_alloc_coherent
   Cyclomatic Complexity 1 include/linux/dma-mapping.h:dma_free_coherent
   Cyclomatic Complexity 1 include/linux/dma-mapping.h:dma_zalloc_coherent
   Cyclomatic Complexity 1 include/linux/unaligned/access_ok.h:get_unaligned_be64
   Cyclomatic Complexity 1 include/scsi/scsi_transport_fc.h:wwn_to_u64
   Cyclomatic Complexity 1 drivers/scsi/qla2xxx/qla_target.h:qla_ini_mode_enabled
   Cyclomatic Complexity 1 drivers/scsi/qla2xxx/qla_target.h:qla_dual_mode_enabled
   Cyclomatic Complexity 5 drivers/scsi/qla2xxx/qla_inline.h:qla2x00_is_reserved_id
   Cyclomatic Complexity 3 drivers/scsi/qla2xxx/qla_inline.h:qla2x00_clear_loop_id
   Cyclomatic Complexity 5 drivers/scsi/qla2xxx/qla_inline.h:qla2x00_get_sp
   Cyclomatic Complexity 4 drivers/scsi/qla2xxx/qla_inline.h:qla2x00_init_timer
   Cyclomatic Complexity 1 include/linux/utsname.h:utsname
   Cyclomatic Complexity 1 drivers/scsi/qla2xxx/qla_gs.c:qla2x00_prep_ct_req
   Cyclomatic Complexity 1 drivers/scsi/qla2xxx/qla_gs.c:qla2x00_gid_pt_rsp_size
   Cyclomatic Complexity 1 drivers/scsi/qla2xxx/qla_gs.c:qla2x00_prep_sns_cmd
   Cyclomatic Complexity 2 drivers/scsi/qla2xxx/qla_gs.c:qla2x00_update_ms_fdmi_iocb
   Cyclomatic Complexity 1 drivers/scsi/qla2xxx/qla_gs.c:qla2x00_prep_ct_fdmi_req
   Cyclomatic Complexity 1 drivers/scsi/qla2xxx/qla_gs.c:qla24xx_prep_ct_fm_req
   Cyclomatic Complexity 4 drivers/scsi/qla2xxx/qla_gs.c:qla2x00_sns_ga_nxt
   Cyclomatic Complexity 6 drivers/scsi/qla2xxx/qla_gs.c:qla2x00_sns_gid_pt
   Cyclomatic Complexity 5 drivers/scsi/qla2xxx/qla_gs.c:qla2x00_sns_gpn_id
   Cyclomatic Complexity 5 drivers/scsi/qla2xxx/qla_gs.c:qla2x00_sns_gnn_id
   Cyclomatic Complexity 3 drivers/scsi/qla2xxx/qla_gs.c:qla2x00_sns_rft_id
   Cyclomatic Complexity 3 drivers/scsi/qla2xxx/qla_gs.c:qla2x00_sns_rnn_id
   Cyclomatic Complexity 7 drivers/scsi/qla2xxx/qla_gs.c:qla_async_rftid
   Cyclomatic Complexity 5 drivers/scsi/qla2xxx/qla_gs.c:qla_async_rffid
   Cyclomatic Complexity 5 drivers/scsi/qla2xxx/qla_gs.c:qla_async_rnnid
   Cyclomatic Complexity 8 drivers/scsi/qla2xxx/qla_gs.c:qla2x00_async_sns_sp_done
   Cyclomatic Complexity 8 drivers/scsi/qla2xxx/qla_gs.c:qla24xx_async_gnnft
   Cyclomatic Complexity 11 drivers/scsi/qla2xxx/qla_gs.c:qla24xx_async_gpsc_sp_done
   Cyclomatic Complexity 4 drivers/scsi/qla2xxx/qla_gs.c:qla24xx_async_gffid_sp_done
   Cyclomatic Complexity 2 drivers/scsi/qla2xxx/qla_gs.c:qla2x00_async_gnnid_sp_done
   Cyclomatic Complexity 2 drivers/scsi/qla2xxx/qla_gs.c:qla2x00_async_gfpnid_sp_done
   Cyclomatic Complexity 6 drivers/scsi/qla2xxx/qla_gs.c:qla2x00_is_a_vp
   Cyclomatic Complexity 29 drivers/scsi/qla2xxx/qla_gs.c:qla2x00_async_gpnft_gnnft_sp_done
   Cyclomatic Complexity 2 drivers/scsi/qla2xxx/qla_gs.c:qla2x00_prep_ms_iocb
   Cyclomatic Complexity 1 drivers/scsi/qla2xxx/qla_gs.c:qla24xx_prep_ms_iocb
   Cyclomatic Complexity 11 drivers/scsi/qla2xxx/qla_gs.c:qla2x00_chk_ms_status
   Cyclomatic Complexity 3 drivers/scsi/qla2xxx/qla_gs.c:qla2x00_fdmi_dhba
   Cyclomatic Complexity 8 drivers/scsi/qla2xxx/qla_gs.c:qla2x00_fdmi_rhba
   Cyclomatic Complexity 19 drivers/scsi/qla2xxx/qla_gs.c:qla2x00_fdmi_rpa
   Cyclomatic Complexity 5 drivers/scsi/qla2xxx/qla_gs.c:qla2x00_ga_nxt
   Cyclomatic Complexity 7 drivers/scsi/qla2xxx/qla_gs.c:qla2x00_gid_pt
   Cyclomatic Complexity 6 drivers/scsi/qla2xxx/qla_gs.c:qla2x00_gpn_id
   Cyclomatic Complexity 6 drivers/scsi/qla2xxx/qla_gs.c:qla2x00_gnn_id
   Cyclomatic Complexity 2 drivers/scsi/qla2xxx/qla_gs.c:qla2x00_rft_id
   Cyclomatic Complexity 2 drivers/scsi/qla2xxx/qla_gs.c:qla2x00_rff_id
   Cyclomatic Complexity 2 drivers/scsi/qla2xxx/qla_gs.c:qla2x00_rnn_id
   Cyclomatic Complexity 2 drivers/scsi/qla2xxx/qla_gs.c:qla2x00_get_sym_node_name
   Cyclomatic Complexity 5 drivers/scsi/qla2xxx/qla_gs.c:qla_async_rsnn_nn
   Cyclomatic Complexity 10 drivers/scsi/qla2xxx/qla_gs.c:qla2x00_fdmiv2_rhba
   Cyclomatic Complexity 21 drivers/scsi/qla2xxx/qla_gs.c:qla2x00_fdmiv2_rpa
   Cyclomatic Complexity 2 drivers/scsi/qla2xxx/qla_gs.c:qla2x00_rsnn_nn
   Cyclomatic Complexity 5 drivers/scsi/qla2xxx/qla_gs.c:qla2x00_mgmt_svr_login
   Cyclomatic Complexity 2 drivers/scsi/qla2xxx/qla_gs.c:qla2x00_prep_ms_fdmi_iocb
   Cyclomatic Complexity 1 drivers/scsi/qla2xxx/qla_gs.c:qla24xx_prep_ms_fdmi_iocb
   Cyclomatic Complexity 12 drivers/scsi/qla2xxx/qla_gs.c:qla2x00_fdmi_register
   Cyclomatic Complexity 6 drivers/scsi/qla2xxx/qla_gs.c:qla2x00_gfpn_id
   Cyclomatic Complexity 17 drivers/scsi/qla2xxx/qla_gs.c:qla2x00_gpsc
   Cyclomatic Complexity 7 drivers/scsi/qla2xxx/qla_gs.c:qla2x00_gff_id
   Cyclomatic Complexity 5 drivers/scsi/qla2xxx/qla_gs.c:qla24xx_async_gidpn
   Cyclomatic Complexity 4 drivers/scsi/qla2xxx/qla_gs.c:qla24xx_post_gidpn_work
   Cyclomatic Complexity 13 drivers/scsi/qla2xxx/qla_gs.c:qla24xx_handle_gidpn_event
   Cyclomatic Complexity 3 drivers/scsi/qla2xxx/qla_gs.c:qla2x00_async_gidpn_sp_done
   Cyclomatic Complexity 2 drivers/scsi/qla2xxx/qla_gs.c:qla24xx_post_gpsc_work
   Cyclomatic Complexity 4 drivers/scsi/qla2xxx/qla_gs.c:qla24xx_handle_gpsc_event
   Cyclomatic Complexity 5 drivers/scsi/qla2xxx/qla_gs.c:qla24xx_async_gpsc
   Cyclomatic Complexity 3 drivers/scsi/qla2xxx/qla_gs.c:qla24xx_post_gpnid_work
   Cyclomatic Complexity 8 drivers/scsi/qla2xxx/qla_gs.c:qla2x00_async_gpnid_sp_done
   Cyclomatic Complexity 3 drivers/scsi/qla2xxx/qla_gs.c:qla24xx_sp_unmap
   Cyclomatic Complexity 25 drivers/scsi/qla2xxx/qla_gs.c:qla24xx_handle_gpnid_event
   Cyclomatic Complexity 12 drivers/scsi/qla2xxx/qla_gs.c:qla24xx_async_gpnid
   Cyclomatic Complexity 1 drivers/scsi/qla2xxx/qla_gs.c:qla24xx_handle_gffid_event
   Cyclomatic Complexity 5 drivers/scsi/qla2xxx/qla_gs.c:qla24xx_async_gffid
   Cyclomatic Complexity 28 drivers/scsi/qla2xxx/qla_gs.c:qla24xx_async_gnnft_done
   Cyclomatic Complexity 1 drivers/scsi/qla2xxx/qla_gs.c:qla24xx_async_gpnft_done
   Cyclomatic Complexity 12 drivers/scsi/qla2xxx/qla_gs.c:qla24xx_async_gpnft
   Cyclomatic Complexity 3 drivers/scsi/qla2xxx/qla_gs.c:qla_scan_work_fn
   Cyclomatic Complexity 1 drivers/scsi/qla2xxx/qla_gs.c:qla24xx_handle_gnnid_event
   Cyclomatic Complexity 5 drivers/scsi/qla2xxx/qla_gs.c:qla24xx_async_gnnid
   Cyclomatic Complexity 4 drivers/scsi/qla2xxx/qla_gs.c:qla24xx_post_gnnid_work
   Cyclomatic Complexity 4 drivers/scsi/qla2xxx/qla_gs.c:qla24xx_handle_gfpnid_event
   Cyclomatic Complexity 5 drivers/scsi/qla2xxx/qla_gs.c:qla24xx_async_gfpnid
   Cyclomatic Complexity 4 drivers/scsi/qla2xxx/qla_gs.c:qla24xx_post_gfpnid_work
   drivers/scsi/qla2xxx/qla_gs.c: In function 'qla2x00_async_gpnft_gnnft_sp_done':
>> drivers/scsi/qla2xxx/qla_gs.c:4094:19: warning: 'rp' may be used uninitialized in this function [-Wmaybe-uninitialized]
          rp->fc4type |= FS_FC4TYPE_NVME;
                      ^~

vim +/rp +4094 drivers/scsi/qla2xxx/qla_gs.c

  3975	
  3976	static void qla2x00_async_gpnft_gnnft_sp_done(void *s, int res)
  3977	{
  3978		struct srb *sp = s;
  3979		struct scsi_qla_host *vha = sp->vha;
  3980		struct qla_work_evt *e;
  3981		struct ct_sns_req *ct_req =
  3982			(struct ct_sns_req *)sp->u.iocb_cmd.u.ctarg.req;
  3983		struct ct_sns_gpnft_rsp *ct_rsp =
  3984			(struct ct_sns_gpnft_rsp *)sp->u.iocb_cmd.u.ctarg.rsp;
  3985		struct ct_sns_gpn_ft_data *d;
  3986		struct fab_scan_rp *rp;
  3987		int i, j, k;
  3988		u16 cmd = be16_to_cpu(ct_req->command);
  3989		u8 fc4_type = sp->gen2;
  3990		u8 found;
  3991		unsigned long flags;
  3992	
  3993		/* gen2 field is holding the fc4type */
  3994		ql_dbg(ql_dbg_disc, vha, 0xffff,
  3995		    "Async done-%s res %x FC4Type %x\n",
  3996		    sp->name, res, sp->gen2);
  3997	
  3998		if (res) {
  3999			unsigned long flags;
  4000	
  4001			sp->free(sp);
  4002			spin_lock_irqsave(&vha->work_lock, flags);
  4003			vha->scan.scan_flags &= ~SF_SCANNING;
  4004			vha->scan.scan_retry++;
  4005			spin_unlock_irqrestore(&vha->work_lock, flags);
  4006	
  4007			if (vha->scan.scan_retry < MAX_SCAN_RETRIES) {
  4008				set_bit(LOCAL_LOOP_UPDATE, &vha->dpc_flags);
  4009				set_bit(LOOP_RESYNC_NEEDED, &vha->dpc_flags);
  4010				qla2xxx_wake_dpc(vha);
  4011			} else {
  4012				ql_dbg(ql_dbg_disc, sp->vha, 0xffff,
  4013				    "Async done-%s rescan failed on all retries\n",
  4014				    sp->name);
  4015			}
  4016			return;
  4017		}
  4018	
  4019		if (!res) {
  4020			port_id_t id;
  4021			u64 wwn;
  4022	
  4023			j = 0;
  4024			for (i = 0; i < vha->hw->max_fibre_devices; i++) {
  4025				d  = &ct_rsp->entries[i];
  4026	
  4027				id.b.rsvd_1 = 0;
  4028				id.b.domain = d->port_id[0];
  4029				id.b.area   = d->port_id[1];
  4030				id.b.al_pa  = d->port_id[2];
  4031				wwn = wwn_to_u64(d->port_name);
  4032	
  4033				if (id.b24 == 0 || wwn == 0)
  4034					continue;
  4035	
  4036				if (fc4_type == FC4_TYPE_FCP_SCSI) {
  4037					if (cmd == GPN_FT_CMD) {
  4038						rp = &vha->scan.l[j];
  4039						rp->id = id;
  4040						memcpy(rp->port_name, d->port_name, 8);
  4041						j++;
  4042						rp->fc4type = FS_FC4TYPE_FCP;
  4043					} else {/* GNN_FT_CMD */
  4044						for (k = 0;
  4045						    k < vha->hw->max_fibre_devices;
  4046						    k++) {
  4047							rp = &vha->scan.l[k];
  4048							if (id.b24 == rp->id.b24) {
  4049								memcpy(rp->node_name,
  4050								    d->port_name, 8);
  4051								break;
  4052							}
  4053						}
  4054					}
  4055				} else { /* FC4_TYPE_NVME */
  4056					if (cmd == GPN_FT_CMD) {
  4057						found = 0;
  4058						for (k = 0;
  4059						    k < vha->hw->max_fibre_devices;
  4060						    k++) {
  4061							rp = &vha->scan.l[k];
  4062							if (!memcmp(rp->port_name,
  4063							    d->port_name, 8)) {
  4064								/*
  4065								 * This remote port
  4066								 * supports NVME & FCP
  4067								 */
  4068								rp->fc4type |=
  4069								    FS_FC4TYPE_NVME;
  4070								found = 1;
  4071								break;
  4072							}
  4073						}
  4074						if (!found) {
  4075							/* find free slot */
  4076							for (k = 0;
  4077							    k < vha->hw->max_fibre_devices;
  4078							    k++) {
  4079								rp = &vha->scan.l[k];
  4080								if (wwn_to_u64
  4081								    (rp->port_name))
  4082									continue;
  4083								else
  4084									/*
  4085									 * found free
  4086									 * slot
  4087									 */
  4088									break;
  4089							}
  4090	
  4091							rp->id = id;
  4092							memcpy(rp->port_name,
  4093							    d->port_name, 8);
> 4094							rp->fc4type |= FS_FC4TYPE_NVME;
  4095						}
  4096	
  4097					} else {/* GNN_FT_CMD */
  4098						for (k = 0;
  4099						    k < vha->hw->max_fibre_devices;
  4100						    k++) {
  4101							rp = &vha->scan.l[k];
  4102							if (id.b24 == rp->id.b24) {
  4103								memcpy(rp->node_name,
  4104								    d->port_name, 8);
  4105								break;
  4106							}
  4107						}
  4108					}
  4109				}
  4110			}
  4111		}
  4112	
  4113		if ((fc4_type == FC4_TYPE_FCP_SCSI) && vha->flags.nvme_enabled &&
  4114		    cmd == GNN_FT_CMD) {
  4115			del_timer(&sp->u.iocb_cmd.timer);
  4116			spin_lock_irqsave(&vha->work_lock, flags);
  4117			vha->scan.scan_flags &= ~SF_SCANNING;
  4118			spin_unlock_irqrestore(&vha->work_lock, flags);
  4119	
  4120			e = qla2x00_alloc_work(vha, QLA_EVT_GPNFT);
  4121			if (!e) {
  4122				/*
  4123				 * please ignore kernel warning. Otherwise,
  4124				 * we have mem leak.
  4125				 */
  4126				if (sp->u.iocb_cmd.u.ctarg.req) {
  4127					dma_free_coherent(&vha->hw->pdev->dev,
  4128					    sizeof(struct ct_sns_pkt),
  4129					    sp->u.iocb_cmd.u.ctarg.req,
  4130					    sp->u.iocb_cmd.u.ctarg.req_dma);
  4131					sp->u.iocb_cmd.u.ctarg.req = NULL;
  4132				}
  4133				if (sp->u.iocb_cmd.u.ctarg.rsp) {
  4134					dma_free_coherent(&vha->hw->pdev->dev,
  4135					    sizeof(struct ct_sns_pkt),
  4136					    sp->u.iocb_cmd.u.ctarg.rsp,
  4137					    sp->u.iocb_cmd.u.ctarg.rsp_dma);
  4138					sp->u.iocb_cmd.u.ctarg.rsp = NULL;
  4139				}
  4140	
  4141				ql_dbg(ql_dbg_disc, vha, 0xffff,
  4142				    "Async done-%s unable to alloc work element\n",
  4143				    sp->name);
  4144				sp->free(sp);
  4145				set_bit(LOCAL_LOOP_UPDATE, &vha->dpc_flags);
  4146				set_bit(LOOP_RESYNC_NEEDED, &vha->dpc_flags);
  4147				return;
  4148			}
  4149			e->u.gpnft.fc4_type = FC4_TYPE_NVME;
  4150			sp->rc = res;
  4151			e->u.gpnft.sp = sp;
  4152	
  4153			qla2x00_post_work(vha, e);
  4154			return;
  4155		}
  4156	
  4157		if (cmd == GPN_FT_CMD)
  4158			e = qla2x00_alloc_work(vha, QLA_EVT_GPNFT_DONE);
  4159		else
  4160			e = qla2x00_alloc_work(vha, QLA_EVT_GNNFT_DONE);
  4161		if (!e) {
  4162			/* please ignore kernel warning. Otherwise, we have mem leak. */
  4163			if (sp->u.iocb_cmd.u.ctarg.req) {
  4164				dma_free_coherent(&vha->hw->pdev->dev,
  4165				    sizeof(struct ct_sns_pkt),
  4166				    sp->u.iocb_cmd.u.ctarg.req,
  4167				    sp->u.iocb_cmd.u.ctarg.req_dma);
  4168				sp->u.iocb_cmd.u.ctarg.req = NULL;
  4169			}
  4170			if (sp->u.iocb_cmd.u.ctarg.rsp) {
  4171				dma_free_coherent(&vha->hw->pdev->dev,
  4172				    sizeof(struct ct_sns_pkt),
  4173				    sp->u.iocb_cmd.u.ctarg.rsp,
  4174				    sp->u.iocb_cmd.u.ctarg.rsp_dma);
  4175				sp->u.iocb_cmd.u.ctarg.rsp = NULL;
  4176			}
  4177	
  4178			ql_dbg(ql_dbg_disc, vha, 0xffff,
  4179			    "Async done-%s unable to alloc work element\n",
  4180			    sp->name);
  4181			sp->free(sp);
  4182			set_bit(LOCAL_LOOP_UPDATE, &vha->dpc_flags);
  4183			set_bit(LOOP_RESYNC_NEEDED, &vha->dpc_flags);
  4184			return;
  4185		}
  4186	
  4187		sp->rc = res;
  4188		e->u.iosb.sp = sp;
  4189	
  4190		qla2x00_post_work(vha, e);
  4191	}
  4192	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 32960 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-nvme/attachments/20180313/8aed896b/attachment-0001.gz>
