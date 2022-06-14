#!/bin/sh

# Antithetic controller
#onemodel-cli export 01_antithetic_controller/protein_constitutive.onemodel
#onemodel-cli export 01_antithetic_controller/protein_induced.onemodel
#onemodel-cli export 01_antithetic_controller/antithetic_controller.onemodel

# Host aware model
onemodel-cli export 02_host_aware_antithetic_controller/host_aware_model/host_aware_model.onemodel
onemodel-cli export 02_host_aware_antithetic_controller/host_aware_antithetic_controller.onemodel
